//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func movieButtonClicked(_ sender: UIButton) {
        
        //화면전환
        //영화버튼 클릭 > BucketlistTableViewController Present
        
        //1. 스토리보드 파일 가져오기
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        //2. 스토리보드 내에 뷰컨트롤러 가져오기
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        //3. 화면전환 구현
        //컴플리션은 화면전환 완료후에 어떻게 할지를 물어보는 옵션
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        
        //1. 스토리보드 파일 가져오기(필수)
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        //2. 스토리보드 내에 뷰컨트롤러 가져오기(필수)
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        //2.5. 뷰컨 present 시 스타일 설정(옵션)
        vc.modalPresentationStyle = .fullScreen
        
        //3. 화면전환 구현(필수)
        //컴플리션은 화면전환 완료후에 어떻게 할지를 물어보는 옵션
        self.present(vc, animated: true)
        
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        
        //1. 스토리보드 파일 가져오기(필수)
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        //2. 스토리보드 내에 뷰컨트롤러 가져오기(필수)
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        //2.5. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        //2.5. 뷰컨 present 시 스타일 설정(옵션)
        //네비게이션 컨트롤러를 임베드 해줬으므로 네비게이션 컨트롤러를 풀스크린으로 설정해줘야함
        nav.modalPresentationStyle = .fullScreen
        
        //3. 화면전환 구현(필수)
        //컴플리션은 화면전환 완료후에 어떻게 할지를 물어보는 옵션
        self.present(nav, animated: true)
        
    }
    
    
}
