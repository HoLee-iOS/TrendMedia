//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBackgroundColor() {
        
        
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "a", message: "b", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
        
    }
    
}
