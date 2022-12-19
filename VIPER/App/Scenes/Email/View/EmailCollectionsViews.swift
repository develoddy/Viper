import UIKit

class EmailCollectionsViews: NSObject {
    
    static func collectionView() -> UICollectionView {
         let collectionView: UICollectionView = UICollectionView(frame:.zero, collectionViewLayout:UICollectionViewCompositionalLayout(sectionProvider:{(_,_) -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem( layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
             
             item.contentInsets = NSDirectionalEdgeInsets(
                 top: 0,
                 leading: 0,
                 bottom: 0,
                 trailing: 3 )
          
             let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .absolute(150) ), subitem: item, count: 3)
             group.contentInsets = NSDirectionalEdgeInsets(
                 top: 3,
                 leading: 0,
                 bottom: 0,
                 trailing: 0)
             
                return NSCollectionLayoutSection( group: group )
        }))
        return collectionView
    }
    
    
    static func emailControllerView() -> UISearchController {
        let viewController = EmailWireFrame.createEmailModule()
        let searchController = UISearchController(searchResultsController: viewController)
        searchController.searchBar.placeholder = "Buscar"
        return searchController
    }
}
