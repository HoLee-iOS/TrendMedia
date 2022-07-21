//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    
    var posterList = [UIImage(systemName: "pencil"),UIImage(systemName: "trash")]
    var movieTitleList = ["해리포터의 죽음의 성물","dasd"]
    var movieDateList = ["2022.01.01","dsadsad"]
    var moviePlotList = ["해리포터 조심해애 볼드모트와 해리포터의 만남","dasdsad"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userTextField.clearButtonMode = .whileEditing
        userTextField.backgroundColor = .systemGray3
        userTextField.textColor = .white
        userTextField.borderStyle = .none
        userTextField.layer.cornerRadius = 10
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTitleList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.backgroundColor = .black
        cell.posterImageView.image = posterList[indexPath.row]
        cell.movieTitleLabel.text = movieTitleList[indexPath.row]
        cell.movieTitleLabel.textColor = .white
        cell.dateLabel.text = movieDateList[indexPath.row]
        cell.dateLabel.textColor = .systemGray6
        cell.plotLabel.text = moviePlotList[indexPath.row]
        cell.plotLabel.textColor = .systemGray5
        
        
        return cell
        
    }

    

}
