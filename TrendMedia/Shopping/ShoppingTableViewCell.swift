//
//  ShoppingTableViewCell.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var listLabel: UILabel!
    
    var checkboxButtonTapped: (() -> Void) = {}
    var starButtonTapped: (() -> Void) = {}
    
    func configureButton() {
        checkboxButton.addTarget(self, action: #selector(checkFill), for: .touchUpInside)
        starButton.addTarget(self, action: #selector(starFill), for: .touchUpInside)
    }
    
    @objc func checkFill() {
        checkboxButtonTapped()
    }
    
    @objc func starFill() {
        starButtonTapped()
    }
    
}
