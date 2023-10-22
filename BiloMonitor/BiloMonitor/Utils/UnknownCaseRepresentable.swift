//
//  UnknownCaseRepresentable.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 21.10.2023.
//

import Foundation

public protocol UnknownCaseRepresentable: RawRepresentable, CaseIterable where RawValue: Equatable {
    static var unknownCase: Self { get }
}

extension UnknownCaseRepresentable {
   public init(rawValue: RawValue) {
        let value = Self.allCases.first(where: { $0.rawValue == rawValue })
        self = value ?? Self.unknownCase
    }
}
