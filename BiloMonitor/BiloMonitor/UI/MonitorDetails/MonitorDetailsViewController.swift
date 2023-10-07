//
//  MonitorDetailsViewController.swift
//  BiloMonitor
//
//  Created by Bilal Durnagöl on 7.10.2023.
//

import UIKit

class MonitorDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var viewModel: MonitorDetailsViewModel!
    
    // MARK: - LIFE CYCLE(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        precondition(viewModel != nil, "viewModel can not be nil!")
        
        setupUI()
    }
    
    // MARK: - HELPER FUNCTION
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
    }
}
