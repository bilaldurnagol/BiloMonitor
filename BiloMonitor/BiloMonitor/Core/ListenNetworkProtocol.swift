//
//  ListenNetworkProtocol.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 7.10.2023.
//

import Foundation

class ListenNetworkProtocol: URLProtocol {
    
    // MARK: - PROPERTIES
    
    fileprivate lazy var session: URLSession = { [unowned self] in
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()
    
    private var responseData: NSMutableData?
    private var response: URLResponse?
    private var currentRequest: RequestModel?
    
    // MARK: - OVERRIDE(s)
    
    override class func canInit(with request: URLRequest) -> Bool {
        return canListenRequest(with: request)
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        
        if task is URLSessionWebSocketTask {
            return false
        }
        
        guard let request = task.currentRequest else { return false }
        
        return canListenRequest(with: request)
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let newRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: Constans.REQUEST_HANDLE_KEY, in: newRequest)
        session.dataTask(with: newRequest as URLRequest).resume()
        
        currentRequest = RequestModel(request: newRequest, session: session)
    }
    
    override func stopLoading() {
        session.getTasksWithCompletionHandler { dataTask, _, _ in
            dataTask.forEach { $0.cancel() }
            self.session.invalidateAndCancel()
        }
    }
}


// MARK: - PRIVATE METHOD(s)

private extension ListenNetworkProtocol {
    /// It decides whether you want to listen or not.
    /// - Parameter request: current request
    /// - Returns: if return TRUE listen but return FALSE not listen
    private class func canListenRequest(with request: URLRequest) -> Bool {
        
        guard BiloMonitorSDK.shared.isEnable else {
            return false
        }
        
        guard URLProtocol.property(forKey: Constans.REQUEST_HANDLE_KEY, in: request) == nil,
            let url = request.url,
            (url.absoluteString.hasPrefix("http") || url.absoluteString.hasPrefix("https")) else {
            return false
        }
        
        return true
    }
}

// MARK: - EXTENSION(s)

extension ListenNetworkProtocol: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData?.append(data)
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response
        responseData = NSMutableData()
        let policy = URLCache.StoragePolicy(rawValue: request.cachePolicy.rawValue) ?? .notAllowed
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: policy)
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
    }
    
}
