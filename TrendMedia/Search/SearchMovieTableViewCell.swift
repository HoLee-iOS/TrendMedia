//
//  SearchMovieTableViewCell.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/20.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    /// 셀에 데이터를 넣어주는 역할
    /// - Parameter data: 영화에 대한 정보 들어있음
    func configureCell(data: Movie) {
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = data.title
        releaseLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        overviewLabel.text = "\(data.overview)"
        overviewLabel.numberOfLines = 0
    }
    
}
