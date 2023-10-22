//
//  RequestModel.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 9.10.2023.
//

import Foundation

public final class RequestModel: Codable {
    public let id: String
    public let url: String?
    public let host: String?
    public let port: Int?
    public let scheme: String?
    public let method: String?
    public let date: Date
    public let time: String?
    public let headers: [String: String]?
    public let httpBody: Data?
    public let bodyLenght: Int?
    public let type: HTTPModelType
    
    public init(request: NSURLRequest, session: URLSession) {
        self.id = UUID().uuidString
        self.url = request.url?.absoluteString
        self.host = request.url?.host
        self.port = request.url?.port
        self.scheme = request.url?.scheme
        self.method = request.httpMethod
        self.date = Date()
        self.time = AppFormatters.date2time(with: date)
        self.headers = request.allHTTPHeaderFields
        self.httpBody = request.httpBody
        self.bodyLenght = request.httpBody?.count
        self.type = HTTPModelType(contentType: headers?["Content-Type"] ?? "")
    }
}


public enum HTTPModelType: String, Codable, UnknownCaseRepresentable {
    public static var unknownCase: HTTPModelType {
        return .UNDEFINED
    }
    case JSON = "JSON"
    case XML = "XML"
    case HTML = "HTML"
    case IMAGE = "Image"
    case UNDEFINED = ""
}

extension HTTPModelType {
    init(contentType: String) {
        if NSPredicate(format: "SELF MATCHES %@", "^application/(vnd\\.(.*)\\+)?json$").evaluate(with: contentType) {
            self = .JSON
        } else if (contentType == "application/xml") || (contentType == "text/xml")  {
            self = .XML
        } else if contentType == "text/html" {
            self = .HTML
        } else if contentType.hasPrefix("image/") {
            self = .IMAGE
        } else {
            self = .UNDEFINED
        }
    }
}
