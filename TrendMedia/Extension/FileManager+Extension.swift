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
        guard let document = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = document.appendingPathComponent(fileName)
        guard let data = image?.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    //도큐먼트에서 이미지 삭제
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
    
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    //도큐먼트에서 이미지 로드
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "heart.fill")
        }
    }
    
}
