//
//  AppFormatters.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 21.10.2023.
//

import Foundation

enum AppDateFormat: String {
    case appTime = "HH:mm"
}

final class AppFormatters {
    
    static func date2time(with date: Date = Date(), dateFormat: AppDateFormat? = .appTime) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat?.rawValue
        return formatter.string(from: date)
    }
}
