//
//  SearchView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit


class SearchView: UIViewController {
    
    
    // MARK: - PROPERTIES
    
    var presenter: SearchPresenterProtocol?
    var searchUI = SearchUI()
    var searchController = SearchCollectionsViews.searchControllerView()
    
    var lastContentOffset: CGFloat = 0

    // MARK: - LIFECYCLE
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        registerCollection()
        delegates()
        configureActivity()
        
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
    
    // LAYOUTS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchUI.frame = view.bounds
        
    }
    
    // REGISTER COLLECTION
    func registerCollection() {
        self.searchUI.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    // DELEGATES
    func delegates() {
        //self.searchUI.collectionView.delegate = self
        //self.searchUI.collectionView.dataSource = self
        
        self.searchController.searchResultsUpdater =  self
        //self.searchController.hidesNavigationBarDuringPresentation = false
        //self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController
        
    }
    
    // ACTIVITY
    func configureActivity() {
        self.searchUI.activityIndicator.center = view.center
        self.searchUI.activityIndicator.hidesWhenStopped = false
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
    

    func updateUI() {
        DispatchQueue.main.async {
            self.searchUI.collectionView.reloadData()
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.searchUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.searchUI.collectionView.alpha = 0.0
            })
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.searchUI.activityIndicator.stopAnimating()
            self.searchUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.searchUI.collectionView.alpha = 1.0
            })
        }
    }
}



// MARK: - UICOLLECTIONS
extension SearchView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {
    
}

extension SearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("SEARCH VIEW:::: kdssklsddskjdskjlksdkdskl.....")
    }
}
