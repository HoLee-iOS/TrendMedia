//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

class BucketlistTableViewController: UITableViewController {

    static let identifier = "BucketlistTableViewController"
    
    @IBOutlet weak var userTextField: UITextField!
    
    var list = ["탑건", "범죄도시2", "헤어질결심"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //아래와 같은 코드들이 실행이 되지 않는다면 네비게이션이 임베드 되지 않은 경우
        navigationItem.title = "버킷리스트"
        //스타일 타겟은 거의 저걸로 고정
        //스타일은 무적권 플레인, 타겟은 누구한테 이 아이템을 설정할지
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        tableView.rowHeight = 80
        
        list.append("마녀2")
        list.append("파송송계란탁")

    }
    
    //selector와 같은 옵젝씨 코드에 값을 넣을때는 아래와 같이 앞에 옵젝씨 어노테이션을 명시해줘야함
    @objc func closeButtonClicked() {
        //화면 뒤로가기
        self.dismiss(animated: true)
        
    }
    
    
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
            list.append(value)
            tableView.reloadData()
        } else {
            //토스트 메시지 띄우기
            
        }
        
        //guard 구문으로 활용
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else{
            //Alert, Toast를 통해서 사용자에게 알려줌
            //해당 함수가 반환 타입이 따로 없기 때문에 return만 써도 됨
            return
        }
        
        list.append(value)
        tableView.reloadData()
        
        
        
//        list.append(sender.text!)
        
        //중요! 데이터가 달라지는 시점에 계속 넣어줘야함
        //잘못넣으면 데이터가 꼬이기 때문에 조심해야함
        //원래는 테이블뷰를 싹 다 다시 만들어서 호출해야되지만 아래 코드로 모두 커버 가능함
//        tableView.reloadData()
        //tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
        //행에 변화를 주는 코드를 입력하면 아래와 같이 행만 다시 리로드 해주는 코드를 실행
        //tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //스토리보드상에서 테이블뷰의 셀을 가지고 옴
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifier, for: indexPath) as! BucketlistTableViewCell // as? 타입 캐스팅
        
        cell.bucketlistLabel.text = list[indexPath.row]
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18) // 15 > 13
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            //배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    
    }
    
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
//    즐겨찾기 핀고정
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }

}
