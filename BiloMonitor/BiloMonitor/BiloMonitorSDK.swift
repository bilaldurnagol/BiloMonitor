//
//  BiloMonitorSDK.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 7.10.2023.
//

import Foundation
import UIKit

public final class BiloMonitorSDK {
    
    // MARK: - PROPERTIES
    
    public static let shared = BiloMonitorSDK()
    
    private(set) var didShowMonitoring = Observable<Bool>()
    
    fileprivate var presentingViewController: UIViewController? {
        var rootViewController = UIWindow.keyWindow?.rootViewController
        while let controller = rootViewController?.presentedViewController {
            rootViewController = controller
        }
        return rootViewController
    }
    
    // MARK: - INIT
    
    private init() { }
    
    // MARK: - METHOD(s)
    
    /// Setup of Bilo Monitor SDK
    public func configuration() {
        didShowMonitoring.bind {[weak self] _ in
            self?.showMonitor(with: self?.presentingViewController)
        }
    }
}

// MARK: - PRIVATE METHOD(s)

extension BiloMonitorSDK {

    /// show to network monitoring view
    /// if is there navigation controller, it use push
    /// if is'n't there navigation controller, if use present
    /// - Parameter rootViewController: root of  last viewcontroller
    private func showMonitor(with rootViewController: UIViewController?) {
        let vc = MonitorViewController()
        vc.viewModel = DefaultMonitorViewModel()
        
        if let navigationViewController = rootViewController as? UINavigationController {
            navigationViewController.pushViewController(vc, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: vc)
            rootViewController?.present(navigationController, animated: true, completion: nil)
        }
    }
}

// MARK: - PUBLIC METHOD(s)

extension BiloMonitorSDK {
    
    /// Detect motion and show motinoring page
    public func motionDetected() {
        didShowMonitoring.value = true
    }
}
