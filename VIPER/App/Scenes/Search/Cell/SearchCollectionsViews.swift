//
//  SearchCollectionsViews.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//

import UIKit

class SearchCollectionsViews: NSObject {
    
    static func collectionView() -> UICollectionView {
         let collectionView: UICollectionView = UICollectionView(frame:.zero, collectionViewLayout:UICollectionViewCompositionalLayout(sectionProvider:{(_,_) -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem( layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                /*item.contentInsets = NSDirectionalEdgeInsets(
                    top: 2,
                    leading: 5,
                    bottom: 2,
                    trailing: 5 )
             
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .absolute(150) ), subitem: item, count: 3)
                group.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 0)*/
             
             item.contentInsets = NSDirectionalEdgeInsets(
                 top: 0,
                 leading: 0,
                 bottom: 0,
                 trailing: 5 )
          
             let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .absolute(150) ), subitem: item, count: 3)
             group.contentInsets = NSDirectionalEdgeInsets(
                 top: 10,
                 leading: 0,
                 bottom: 10,
                 trailing: 0)
             
                return NSCollectionLayoutSection( group: group )
        }))
        return collectionView
    }
    
    
    static func searchControllerView() -> UISearchController {
        
        let viewController = SearchResultWireFrame.createSearchResultModule(filter: "")
        let searchController = UISearchController(searchResultsController: viewController)
        searchController.searchBar.placeholder = "Buscar"
        //searchController.searchBar.searchBarStyle = .minimal
        //searchController.definesPresentationContext = true
        return searchController
    }
}
