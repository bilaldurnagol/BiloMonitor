//
//  ViewController.swift
//  BiloMonitorDemo
//
//  Created by Bilal Durnagöl on 1.10.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - LIFE CYCLE(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // İstek yapılacak URL'yi oluşturun
        if let url = URL(string: "https://example.com/api/data") {
            
            // URLSession nesnesini oluşturun
            let session = URLSession.shared
            
            // URLSessionDataTask'i oluşturun
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Hata oluştu: \(error)")
                } else if let data = data {
                    // Yanıt verilerini işleyin
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Yanıt: \(responseString)")
                    }
                }
            }
            
            // İsteği başlatın
            task.resume()
        } else {
            print("Geçersiz URL")
        }

    }


}

