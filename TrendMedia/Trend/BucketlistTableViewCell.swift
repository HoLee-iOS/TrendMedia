//
//  BucketListTableViewCell.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

class BucketlistTableViewCell: UITableViewCell {

    static let identifier = "BucketlistTableViewCell"
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var bucketlistLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

}
