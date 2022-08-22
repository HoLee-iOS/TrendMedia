//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {
    
    static let identifier = "BucketlistTableViewController"
    
    //클래스는 ReferenceType -> 인스턴스 자체를 변경하지 않는 이상 한번만 됨
    //IBOutlet ViewDidLoad 호출 되기 직전에 nil이 아닌 지 nil인지 알 수 있음!
    @IBOutlet weak var userTextField: UITextField!{
        didSet{
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
        }
    }
    
    //list 프로퍼티가 추가, 삭제 등 변경되고나서 테이블뷰를 항상 갱신!
    //딕셔너리로 값을 관리하면 될까?
    //key는 중복될 수 없기 때문에 value가 Bool 타입이 되게 해야함
    //딕셔너리는 순서가 없기 때문에 대입 불가
    var list = [Todo(title: "범죄도시2", done: false), Todo(title: "탑건", done: true)] {
        didSet { //리스트가 변경되면 아래의 코드가 자동으로 실행
//            tableView.reloadData()
            print("list가 변경됨! \(list), \(oldValue)")
        }
    }
    
    //1.데이터를 받을 공간 생성
    //옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유는
    //값을 할당하는 프로퍼티 자체가 옵셔널이기 때문
    //하지만 문자열 보간법을 사용한다면 내부에서 옵셔널을 벗겨서 사용해줘야함
    var textfieldPlaceholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3.받은 데이터를 뷰에 표현
        //textfieldPlaceholder를 nil로 설정해줘도 placeholder의 원래 타입이 옵셔널 타입이기 때문에 따로 옵셔널을 벗겨주지 않아도 괜찮음
        //아래와 같이 문자열보간법을 사용한다면 옵셔널을 무조건 벗겨줘야함
        //옵셔널 체이닝을 이용해서 벗겨줌
        userTextField.placeholder = "\(textfieldPlaceholder ?? "영화")를 입력해보세요"
        
        //아래와 같은 코드들이 실행이 되지 않는다면 네비게이션이 임베드 되지 않은 경우
        navigationItem.title = "버킷리스트"
        //스타일 타겟은 거의 저걸로 고정
        //스타일은 무적권 플레인, 타겟은 누구한테 이 아이템을 설정할지
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        tableView.rowHeight = 80
        
        list.append(Todo(title: "마녀2", done: false))
        
    }
    
    //selector와 같은 옵젝씨 코드에 값을 넣을때는 아래와 같이 앞에 옵젝씨 어노테이션을 명시해줘야함
    @objc func closeButtonClicked() {
        //화면 뒤로가기
        self.dismiss(animated: true)
        
    }
    
    
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        //        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
        //            list.append(value)
        //            tableView.reloadData()
        //        } else {
        //            //토스트 메시지 띄우기
        //
        //        }
        
        //guard 구문으로 활용
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else{
            //Alert, Toast를 통해서 사용자에게 알려줌
            //해당 함수가 반환 타입이 따로 없기 때문에 return만 써도 됨
            return
        }
        
        list.append(Todo(title: sender.text!, done: false))
        //        tableView.reloadData()
        //didset 구문을 이용하면 데이터의 변경에 대한 대응을 따로 신경쓰지않아도 괜찮음
        
        
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
        
        cell.bucketlistLabel.text = list[indexPath.row].title
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18) // 15 > 13
        
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkBoxButtonClicked(sender:)), for: .touchUpInside)
        
        //2.이미지 변경 조건 넣어줌
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    @objc func checkBoxButtonClicked(sender: UIButton) {
        print("\(sender.tag)번째 버튼 클릭!")
        
        //배열 인덱스를 찾아서 done을 바꾸고 테이블뷰 갱신 해야됨
        //1.done을 바꿈
        list[sender.tag].done = !list[sender.tag].done
        
        //3.테이블 뷰 전체를 갱신하지 않고 효율적으로 해당 행만 갱신해줌
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        
//        if list[sender.tag].done {
//            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//            list[sender.tag].done = false
//        } else {
//            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
//            list[sender.tag].done = true
//        }
        
        //재사용 셀 오류 확인용 코드
        //sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            //배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            //            tableView.reloadData()
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
