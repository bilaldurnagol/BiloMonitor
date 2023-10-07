//
//  MonitorViewModel.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 7.10.2023.
//

import Foundation


// MARK: - VIEW MODEL INPUT(s)

protocol MonitorViewModelInput {
    
}

// MARK: - VIEW MODEL OUTPUT(s)

protocol MonitorViewModelOutput {
    
}

/// Alias for view model input and output
typealias MonitorViewModel = MonitorViewModelInput & MonitorViewModelOutput

/// Monitor view model implementation
final class DefaultMonitorViewModel: MonitorViewModel {
    
}
