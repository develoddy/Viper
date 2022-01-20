//
//  ProfileCollectionsViews.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 18/1/22.
//

import UIKit

class ProfileCollectionsViews: NSObject {

    static func collectionViewOne() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionViewOne = UICollectionView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 120), collectionViewLayout: layout)
        collectionViewOne.backgroundColor = .systemGray3
        return collectionViewOne
    }
    
    static func collectionViewThree() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionViewThree = UICollectionView(frame: CGRect(x: 0, y: self.collectionViewOne().bottom+5 , width: UIScreen.main.bounds.size.width, height: 70), collectionViewLayout: layout)
        collectionViewThree.backgroundColor = .systemBlue
        collectionViewThree.isScrollEnabled = false
        return collectionViewThree
    }

    static func collectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (UIScreen.main.bounds.size.width-4)/3
        layout.itemSize = CGSize(width: size, height: size)
        let collectionViewTwo = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTwo.backgroundColor = .clear
        return collectionViewTwo
    }
}

