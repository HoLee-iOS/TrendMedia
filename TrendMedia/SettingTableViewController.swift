//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var birthdayFriends = ["뽀로로", "루피", "올라프", "스노기", "모구리", "고래밥"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    //섹션의 갯수(옵션)
    //섹션의 갯수는 디폴트값이 1로 되어 있음
    //씬에 표현이 되는 건 셀의 갯수 * 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //각 섹션의 헤더 이름 설정
    //아래와 같은 함수에 섹션 파라미터를 따로 만들어주는 이유는 각 섹션의 따로 값을 설정해주기 위해서이다(각 섹션은 인덱스 값으로 구분 가능)
    //셀 개수가 배열 요소 개수랑 같은지 확인
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else {
            return "친구 140명"
        }
    
    }
    
    //각 섹션의 푸터 이름 설정
    //푸터는 잘 사용하지 않음
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return "푸터"
        
    }
    
    //1. 셀의 갯수(필수): numberOfRowsInSection
    //ex. 카톡 100명 > 셀 100개, 3000명 > 셀 3000개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //조건문을 이용하여 섹션마다 셀의 갯수를 다르게 설정해줌
        //모든 경우의 수에 대응해야되기 때문에 마지막 경우나 섹션 값이 범위의 바깥의 경우의 else를 써줘야함
        //벌스데이프렌즈 갯수 안맞을 경우
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
        
    }
    
    //2. 셀의 디자인과 데이터(필수): cellForRowAt
    //ex. 카톡 이점팔, 프로필 사진, 상태 메시지 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //셀의 복붙을 해줌 * 100
        //인스턴스는 상수로 만들었지만 클래스 내부의 속성은 변수로 선언되어 있기 때문에 속성 값은 변경이 가능함
        //셀코드 입력 잘못해서 나오는 에러
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        if indexPath.section == 0 {
            
            
            //텍스트라벨은 인제 곧 1,2년 뒤에는 deprecated될 코드
            //텍스트레이블이 옵셔널 타입이기 때문에 ?가 들어감
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1 {
            //텍스트라벨은 인제 곧 1,2년 뒤에는 deprecated될 코드
            cell.textLabel?.text = "1번 인덱스 텍스트"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .italicSystemFont(ofSize: 25)
        } else if indexPath.section == 2 {
            //텍스트라벨은 인제 곧 1,2년 뒤에는 deprecated될 코드
            cell.textLabel?.text = "2번 인덱스 색션의 텍스트"
            cell.textLabel?.textColor = .systemGreen
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        //마지막에 셀을 리턴해주기 때문에 여기서는 else를 써주지 않아도 모든 경우를 커버하기 때문에 오류 뜨지 않음
        return cell
    }

}
