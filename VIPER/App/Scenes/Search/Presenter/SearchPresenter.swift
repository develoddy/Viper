//
//  SearchPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit

class SearchPresenter {
    
    // MARK: PROPERTIES
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var wireFrame: SearchWireFrameProtocol?
    var token = Token()
    var page: Int?
    
    //var viewModel: [Post] = [] {
    var postViewData: [PostViewData] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
}


// MARK: - FUNCTIONS
extension SearchPresenter: SearchPresenterProtocol {
  
    func getTotalPages() -> Int {
        return self.page ?? 0
    }
    
    
    func viewDidLoad() {
        guard let token = token.getUserToken().success else { return }
        
        //LLAMAR AL INTERACTOR
        self.interactor?.interactorGetData(page: 0, isPagination:false, token: token)
        view?.startActivity()
    }
    
    // GET NUMBER OF SECTION
    func numberOfSections() -> Int {
        return 1
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        
        //return (self.viewModel.count > 0) ? (self.viewModel.count + 1) : 0
        
        if self.postViewData.count != 0 {
            return self.postViewData.count
        }
        return 0
    }
    
    // GET DATA
    func showUserpostData(indexPath: IndexPath) -> PostViewData /*Post*/ {
        return self.postViewData[indexPath.row]
    }
    
    // SEARCH FILTER
    func searchResultsUpdating(resultsComtroller: SearchResultView, filter: String) {
        // LLAMAR AL WIREFRAME
        self.wireFrame?.gotoSearchResultsUpdating(from: self.view!, resultsComtroller: resultsComtroller, filter: filter)
    }
    
    // LLAMAR AL WIREFRAME.
    func gotoPostScreen(post: PostViewData?/*Post?*/) {
        self.wireFrame?.navigateToPost(from: view!, post: post)
    }
    
    func loadMoreData(page: Int) {
        guard let token = token.getUserToken().success else {
            return
        }
        
        self.interactor?.interactorGetData(page: page, isPagination: true, token: token)
        //view?.startActivity()
    }
}


// MARK: - OUT PUT
extension SearchPresenter: SearchInteractorOutputProtocol {
    // MARK: FUNCTIONS
    func interactorCallBackDataAppend(userpost: [Post]) {
        
        let formattedItems = userpost.map{PostViewData(info: $0)}
        
        for item in formattedItems {
            self.postViewData.append(item)
        }
        //view?.stopActivity()
    }

    // EL PRESENTER RECIBE LOS DATOS DEL INTERACTOR
    func interactorCallBackData(userpost: [Post], totalPages: Int) {
        let formattedItems = userpost.map{PostViewData(info: $0)}
        self.postViewData = formattedItems
        //self.viewModel = userpost
        self.page = totalPages
        view?.stopActivity()
    }
}
