import Foundation
import UIKit


class SearchView: UIViewController {
    // MARK: PROPERTIES
    
    var presenter: SearchPresenterProtocol?
    var searchUI = SearchUI()
    var searchController = SearchCollectionsViews.searchControllerView()
    var page: Int! = 0
    
    var totalPages:Int!
    var postsQuantity:Int!
    
    var lastContentOffset: CGFloat = 0
    
    var isLoading: Bool = false
    


    // MARK: LIFECYCLE
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        configureActivity()
        registerCollection()
        delegates()
        
    }
    
    // LOAD DATA
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    // SETUP
    func setupView() {
        view.backgroundColor = .systemBackground
        self.view.addSubview(searchUI)
    }
    
    // ACTIVITY
    func configureActivity() {
        
        self.searchUI.activityIndicator.center = view.center
        self.searchUI.activityIndicator.hidesWhenStopped = false
    }
    
    // LAYOUTS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchUI.collectionView.frame = view.bounds
        self.searchUI.frame = view.bounds
        self.searchUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
        
    }
    
    // REGISTER COLLECTION
    func registerCollection() {
        self.searchUI.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        self.searchUI.collectionView.register(IndicatorCell.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,withReuseIdentifier: IndicatorCell.identifier)
    }
    
    // DELEGATES
    func delegates() {
        self.searchUI.collectionView.delegate = self
        self.searchUI.collectionView.dataSource = self
        
        self.searchController.searchResultsUpdater =  self
        //self.searchController.hidesNavigationBarDuringPresentation = false
        //self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController
        
    }
}


// MARK: - SEARCH RESULT
extension SearchView: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let resultsComtroller = searchController.searchResultsController as? SearchResultView,
              let filter = searchController.searchBar.text, !filter.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        self.presenter?.searchResultsUpdating(resultsComtroller: resultsComtroller, filter: filter)
        
    }
}


// MARK: - OUT PUT
extension SearchView: SearchViewProtocol {
    func postsCount(count: Int, totalPages: Int) {
        // 
    }
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.searchUI.collectionView.reloadData()
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.searchUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2,
                animations: {
                self.searchUI.collectionView.alpha = 0.0
                })
        }
    }
    
    func stopActivity() {
        
        //DispatchQueue.main.asyncAfter(deadline: .now()+6) {
        DispatchQueue.main.async {
            self.searchUI.activityIndicator.stopAnimating()
            self.searchUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.searchUI.collectionView.alpha = 1.0
            })
        }
    }
}



// MARK: - COLLETION VIEW
extension SearchView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 { return 0 }
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //if indexPath.row < self.presenter?.getTotalPages() ?? 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            let post = self.presenter?.showUserpostData(indexPath: indexPath)
            cell.setCellWithValuesOf(with: post)
            return cell
        //} else {
        //    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.identifier, for: indexPath) as! IndicatorCell
        //    cell.inidicator.startAnimating()
        //    return cell
        //}
    }
    
}

extension SearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // LLAMAR AL PRESENTER.
        self.presenter?.gotoPostScreen(post: self.presenter?.showUserpostData(indexPath: indexPath))
    }
    
    // SCROLL
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && (self.presenter?.getTotalPages())!-1 != self.page {
            guard let isPaginationOn = presenter?.interactor?.remoteDatamanager?.isPaginationOn else {
                return
            }
            guard !isPaginationOn else {
                return
            }
            self.page += 1
            self.presenter?.loadMoreData(page: self.page)
        }
        
        /*let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height // scrollView.contentSize.height-100-scrollView.frame.size.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if distanceToBottom < 500 && self.presenter?.getTotalPages() != self.page {
         guard !self.isLoading else { return }
         self.isLoading = true
         print(self.isLoading)
         // cargar más datos
         // que establecer self.isLoading en falso cuando se cargan nuevos datos
            self.page += 1
            elf.presenter?.loadMoreData(page: self.page)
        }*/
        
    }
}


extension SearchView: UICollectionViewDelegateFlowLayout {
}
