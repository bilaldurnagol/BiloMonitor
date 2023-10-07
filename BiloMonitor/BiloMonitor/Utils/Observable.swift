//
//  Observable.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 7.10.2023.
//

import Foundation

public class Observable<T> {
    public var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    public var observer: ((T?) -> ())?
    
    public init() { }
    
    public func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
