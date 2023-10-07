//
//  MonitorDetailsViewModel.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 7.10.2023.
//

import Foundation


// MARK: - VIEW MODEL INPUT(s)

protocol MonitorDetailsViewModelInput {
    
}

// MARK: - VIEW MODEL OUTPUT(s)

protocol MonitorDetailsViewModelOutput {
    
}

/// Alias for view model input and output
typealias MonitorDetailsViewModel = MonitorDetailsViewModelInput & MonitorDetailsViewModelOutput

/// Monitor  detail view model implementation
final class DefaultMonitorDetailsViewModel: MonitorDetailsViewModel {
    
}
