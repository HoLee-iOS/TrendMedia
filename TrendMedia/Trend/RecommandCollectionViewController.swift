//
//  RecommandCollectionViewController.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher

/*
 TableView > CollectionView
 Row > Item
 heightForRowAt > ??? FlowLayout (heightForItemAt이 없는 이유)
*/

class RecommandCollectionViewController: UICollectionViewController {

    //1. 값 전달 - 데이터를 받을 공간(프로퍼티) 생성
    var movieData: Movie?
    
    
    var image = "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3. 값 전달 - 프로퍼티 값을 뷰에 표현
        title = movieData?.title
        
        
        
        //컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3 , height: (width / 3) * 1.2 ) //init과 같음
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        //위에서 설정한 속성 값을 컬렉션뷰에 할당해줌
        collectionView.collectionViewLayout = layout
        
        //Compositial Layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as? RecommandCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.posterImageView.backgroundColor = .green
        
        //위에서 따로 url로 변수를 만들어주더라도 안에서 url을 따로 호출해서 사용해야함
        let url = URL(string: image)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        view.makeToast("\(indexPath.item)번째 셀을 선택했습니다", duration: 1, position: .center)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
