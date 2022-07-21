//
//  SearchMovieTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/20.
//

import UIKit

class SearchMovieTableViewController: UITableViewController {

    var movieList = MovieInfo() //구조체에 더 다양한 프로퍼티를 가져와야한다면 인스턴스만 불러와서 해당 구조체의 프로퍼티명을 아래에 따로 해주는 게 더 좋음
    //Movie(movieTitle: "암살", movieRelease: "22.22.22", movieOverview: "암살 줄거리", movieRuntime: 150, movieRate: 8.8),
    //Movie(movieTitle: "해리포터", movieRelease: "11.11.11", movieOverview: "해리포터 줄거리", movieRuntime: 140, movieRate: 9.0)
    
    //["암살", "해리포터", "기묘한 이야기", "내 머리속의 지우개", "라이언 일병 구하기", "라라랜드", "괴물", "외계+인"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as! SearchMovieTableViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8 //전체 디바이스의 높이 / 8
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt") //동작하지 않는다면? 1. TableView기 noSelection 2. 셀 위에 전체 버튼
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RecommandCollectionViewController") as! RecommandCollectionViewController
        
        //푸쉬는 무조건 네비게이션이 필요하기 때문에 먼저 네비게이션 유무 확인하고 푸쉬
        //네비게이션이 없다면 아무 일이 일어나지 않기 때문에 동작을 안한다면 네비게이션 임베드 해주기
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
