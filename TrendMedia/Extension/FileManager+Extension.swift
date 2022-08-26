//
//  FileManager+Extension.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/08/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    //도큐먼트에 이미지 저장
    func saveImageToDocument(fileName: String, image: UIImage?) {
        
        let fileManager = FileManager.default
        
        guard let document = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        
        //이미지를 담을 폴더 생성
        let directoryPath = document.appendingPathComponent("Images")
        print("directoryPath: \(directoryPath)")
        
        if !fileManager.fileExists(atPath: directoryPath.path) {
            do {
                try fileManager.createDirectory(atPath: directoryPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create document directory")
            }
        }
        
        //폴더에 이미지 저장
        let filePath = directoryPath.appendingPathComponent(fileName)
        print("filePath: \(filePath)")
        
        if !fileManager.fileExists(atPath: filePath.path) {
            guard let data = image?.jpegData(compressionQuality: 0.5) else { return }
            do {
                try data.write(to: filePath)
            } catch let error {
                print("이미지 저장 실패", error)
            }
        }
    }
    
    
    //도큐먼트에서 이미지 삭제
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        let directoryPath = documentDirectory.appendingPathComponent("Images") //폴더 경로
        let fileURL = directoryPath.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error{
            print("이미지 삭제 실패", error)
        }
    }
    
    //도큐먼트에서 이미지 로드
    func loadImageFromDocument(fileName: String) -> UIImage? {
        
        let fileManager = FileManager.default
        
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //Document 경로
        let directoryPath = documentDirectory.appendingPathComponent("Images") //Directory 경로
        let fileURL = directoryPath.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
        print(fileURL)
//        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                return UIImage(contentsOfFile: fileURL.path)
            } else {
                return UIImage(systemName: "heart.fill")
            }
            
//        } catch le {
//            print("이미지 로드 실패")
//        }
    }
    
    //도큐먼트 경로 가져오기
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func fetchDocumentZipFile() -> [String] {
        
        var result: [String] = []
        
        do {
            guard let path = documentDirectoryPath() else { return [""] }
            
            //includingPropertiesForKeys: 더 추가적인 정보를 가져오는 것 [.으로 가져올 수 있음]
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            //확장자가 zip인 애를 가져오기
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("zip: \(zip)")
            
            //zip파일 경로에서 가장 마지막 컴포넌트인 zip 파일명만 가져오기
            result = zip.map { $0.lastPathComponent }
            print("result: \(result)")
            
        } catch {
            print("Error")
        }
        
        return result
        
    }
    
    
}
