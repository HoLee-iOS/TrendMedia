//
//  ViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    //언제 아웃렛컬렉션을 사용하는 것이 좋을까?
    //
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    @IBOutlet weak var yellowViewLeadingConstant: NSLayoutConstraint!
    
    //변수의 스코프
    //디데이앱과 같이 포멧을 자주 사용해야하는 앱이라면 바깥에 선언을 해주어서 어디에서든 사용가능하게 만들어줌
    let format = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //그래서 이런 식으로 계속 같은 형태의 날짜를 이용한다면 뷰디드로드에서 사용 하는 것이 좋음
        //아래의 포맷 설정 코드는 언제 실행이 될지 모르기 때문에 viewDidLoad보다 높은 스코프에서 사용 불가함
        format.dateFormat = "yyyy/MM/dd"
        
        yellowViewLeadingConstant.constant = 120
        
    }

    //전체적인 같은 속성의 다자인을 줄 때는 컬렉션을 사용해도 괜찮음
    func configureLabelDesign() {
        //1.OutletCollection
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
        }
        
        dateLabelCollection[0].text = "첫번째 텍스트"
        dateLabelCollection[1].text = "두번째 텍스트"
        
        //2.UILabel
        let labelArray = [dateLabel, date2Label]
        for i in labelArray {
            for i in labelArray {
                i?.font = .boldSystemFont(ofSize: 20)
                i?.textColor = .brown
            }
        }
        
        dateLabel.text = "첫번째 텍스트"
        date2Label.text = "두번째 텍스트"
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        dateLabel.text = format.string(from: sender.date)
        
    }
    
    
    
}

