//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    var list = ["그립톡", "사이다"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.borderStyle = .none
        userTextField.layer.cornerRadius = 10
        userTextField.backgroundColor = .systemGray6
        userTextField.attributedPlaceholder = NSAttributedString(string: "  무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .systemGray5
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        
        
        
    }

    func showAlertController() {
        
        let alert = UIAlertController(title: "뭐라도 입력하세요", message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        print(userTextField.text)
        
        if userTextField.text != "" {
                
            list.append(sender.text!)
            
            tableView.reloadData()
            
        } else {
         
            showAlertController()
            
        }
        
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        if userTextField.text != "" {
                
            list.append(userTextField.text!)
            
            tableView.reloadData()
            
        } else {
         
            showAlertController()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTestViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.listLabel.text = list[indexPath.row]
        cell.listLabel.font = .boldSystemFont(ofSize: 15)
        cell.checkboxButton.isSelected.toggle()
        cell.starButton.isSelected.toggle()
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    

}
