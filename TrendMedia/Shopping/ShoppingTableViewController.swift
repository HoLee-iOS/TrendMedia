//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

import RealmSwift

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let localRealm = try! Realm()
    
    var tasks: Results<ShoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "content", ascending: true)
        
        userTextField.borderStyle = .none
        userTextField.layer.cornerRadius = 10
        userTextField.backgroundColor = .systemGray6
        userTextField.attributedPlaceholder = NSAttributedString(string: "  무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .systemGray5
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        let task = ShoppingList(content: userTextField.text!)
        
        try! localRealm.write {
            localRealm.add(task)
            print("저장성공")
            tableView.reloadData()
        }
        userTextField.text = nil
        view.endEditing(true)
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        let task = ShoppingList(content: userTextField.text!)
        
        try! localRealm.write {
            localRealm.add(task)
            print("저장성공")
            tableView.reloadData()
        }
        userTextField.text = nil
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTestViewCell", for: indexPath) as! ShoppingTableViewCell
        
        let taskUpdate = tasks[indexPath.row]
        
        cell.listLabel.text = taskUpdate.content
        cell.listLabel.font = .boldSystemFont(ofSize: 15)
        
        cell.configureButton()
        
        taskUpdate.check ? cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) : cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        
        taskUpdate.favorite ? cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal) : cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        cell.checkboxButtonTapped = {
            try! self.localRealm.write {
                taskUpdate.check = !taskUpdate.check
            }
            self.tableView.reloadData()
        }
        
        cell.starButtonTapped = {
            try! self.localRealm.write {
                taskUpdate.favorite = !taskUpdate.favorite
            }
            self.tableView.reloadData()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let taskDelete = tasks[indexPath.row]
        
        if editingStyle == .delete {
            try! self.localRealm.write {
                self.localRealm.delete(taskDelete)
            }
            tableView.reloadData()
        }
        
    }
}
