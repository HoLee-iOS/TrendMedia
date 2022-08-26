//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/19.
//

import UIKit

import PhotosUI
import RealmSwift
import Zip

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let localRealm = try! Realm()
    
    var tasks: Results<ShoppingList>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var objectID: ObjectId?
    
    //정렬 메뉴버튼
    let menuButton1: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "list.dash")
        button.tintColor = .black
        return button
    }()
    
    //백업/복구 메뉴버튼
    let menuButton2: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "ellipsis")
        button.tintColor = .black
        return button
    }()
    
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
        
        
        //우측 정렬 메뉴 버튼 추가
        navigationItem.rightBarButtonItem = menuButton1
        
        let sortContent = UIAction(title: "할 일 기준 정렬") { _ in
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "content", ascending: true)
        }
        
        let sortFavorite = UIAction(title: "즐겨찾기순 정렬") { _ in
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "favorite", ascending: false)
        }
        
        let sortCheck = UIAction(title: "체크순 정렬") { _ in
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "check", ascending: false)
        }
        
        let cancel1 = UIAction(title: "취소", attributes: .destructive) { _ in
            print("취소")
        }
        
        menuButton1.menu = UIMenu(title: "",
                                  image: UIImage(systemName: "heart.fill"),
                                  identifier: nil,
                                  options: .destructive,
                                  children: [sortContent, sortFavorite, sortCheck, cancel1])
        
        
        //좌측 백업/복구 버튼 추가
        navigationItem.leftBarButtonItem = menuButton2
        
        let backUp = UIAction(title: "백업") { _ in
            
            let fileManager = FileManager.default
            
            var urlPaths = [URL]()
            
            guard let path = self.documentDirectoryPath() else { return }
            
            //데이터베이스 파일
            let realmFile = path.appendingPathComponent("default.realm")
            //이미지 파일
            let imageFile = path.appendingPathComponent("Images")
            
            guard fileManager.fileExists(atPath: realmFile.path) else { return }
            guard fileManager.fileExists(atPath: imageFile.path) else { return }
            
            urlPaths.append(URL(string: realmFile.path)!)
            urlPaths.append(URL(string: imageFile.path)!)
            
            //배열 합치기
//            let combined = Array(zip(urlPaths1, urlPaths2))
            
            do {
                let zipFilePath = try Zip.quickZipFiles(urlPaths , fileName: "List1")
                print("Archive Location: \(zipFilePath)")
                self.showActivityViewController()
            } catch {
                print("압축 실패")
            }
            
            
        }
        
        let restore = UIAction(title: "복구") { _ in
            
            //asCopy를 이용해서 백업 파일을 복사해서 가져올 것인지를 정함
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            self.present(documentPicker, animated: true)
            
        }
        
        let cancel2 = UIAction(title: "취소", attributes: .destructive) { _ in
            print("취소")
        }
        
        menuButton2.menu = UIMenu(title: "",
                                  image: nil,
                                  identifier: nil,
                                  options: .displayInline,
                                  children: [backUp, restore, cancel2])
        
        
    }
    
    func showActivityViewController() {
        
        //도큐먼트 위치 가져오기
        guard let path = self.documentDirectoryPath() else {
            print("도큐먼트 위치 오류")
            return
        }
        //도큐먼트 내부의 백업할 Realm 파일에 대한 세부 경로를 추가해줌
        let backUpFileURL = path.appendingPathComponent("List1.zip")
        
        let vc = UIActivityViewController(activityItems: [backUpFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        
        
        //phpicker 생성
        let configuration = PHPickerConfiguration()
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
        
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
            
            print(taskDelete.objectId)
            
            removeImageFromDocument(fileName: "\(taskDelete.objectId).jpg")
            
            try! self.localRealm.write {
                self.localRealm.delete(taskDelete)
            }
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasks[indexPath.row]
        
        let vc = ShoppingDetailViewController()
        
        vc.detailLabel.text = task.content
        
        if task.check {
            vc.detailCheck.text = "이미 구매한 상품입니다😊"
        } else {
            vc.detailCheck.text = "아직 구매하지 않은 상품입니다🙂"
        }
        
        if task.favorite {
            vc.detailFavorite.text = "즐겨찾기하신 상품입니다😁"
        } else {
            vc.detailFavorite.text = "즐겨찾기가 되지 않은 상품입니다🥹"
        }
        
        print(task.objectId)
        vc.detailImage.image = loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ShoppingTableViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let task = ShoppingList(content: userTextField.text!)
        
        objectID = task.objectId
        
        let itemProvider = results.first?.itemProvider
        
        try! localRealm.write {
            localRealm.add(task)
            print("저장성공")
            tableView.reloadData()
        }
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard let objectId = self.objectID else { return }
                guard let itemImage = image else { return }
                self.saveImageToDocument(fileName: "\(objectId).jpg", image: itemImage as? UIImage)
            }
        }
        
        
        picker.dismiss(animated: true)
    }
}

extension ShoppingTableViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        //documentPicker에서 선택한 파일의 URL 가져오기
        guard let selectedFileURL = urls.first else {
            print("선택한 파일 없음")
            return
        }
        
        //도큐먼트 위치 가져오기
        guard let path = self.documentDirectoryPath() else {
            print("위치 오류 있음")
            return
        }
        
        //도큐먼트 위치 내부에서 documentPicker에서 선택한 파일의 URL을 가져오기
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        //documentPicker에서 선택한 해당 파일이 존재하면 파일 압축 풀기
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            print(sandboxFileURL)
            let fileURL = path.appendingPathComponent("List1.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    print("복구 완료")
                })
                
            } catch {
                print("압축해제 실패1")
            }
            
        } else {
            
            //파일이 존재하지 않을 때
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("List1.zip") //폴더 생성, 폴더 안에 파일 저장
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    print("복구 완료")
                })
                
            } catch {
                print("압축해제 실패2")
            }
            
        }
        
        
    }
    
}









