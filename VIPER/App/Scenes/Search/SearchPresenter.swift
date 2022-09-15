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
    
    var viewModel: [Post] = [] {
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
        
        if self.viewModel.count != 0 {
            return self.viewModel.count
        }
        return 0
    }
    
    // GET DATA
    func showUserpostData(indexPath: IndexPath) -> Post {
        return self.viewModel[indexPath.row]
    }
    
    // SEARCH FILTER
    func searchResultsUpdating(resultsComtroller: SearchResultView, filter: String) {
        // LLAMAR AL WIREFRAME
        self.wireFrame?.gotoSearchResultsUpdating(from: self.view!, resultsComtroller: resultsComtroller, filter: filter)
    }
    
    // LLAMAR AL WIREFRAME.
    func gotoPostScreen(post: Post?) {
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
        for item in userpost {
            self.viewModel.append(item)
        }
        //view?.stopActivity()
    }

    // EL PRESENTER RECIBE LOS DATOS DEL INTERACTOR
    func interactorCallBackData(userpost: [Post], totalPages: Int) {
        self.viewModel = userpost
        self.page = totalPages
        view?.stopActivity()
    }
}
