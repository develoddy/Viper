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
    
    var viewModel: [Post] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
}


// MARK: - FUNCTIONS
extension SearchPresenter: SearchPresenterProtocol {
    
    // TODO: -  FUNCTIONS
    
    func viewDidLoad() {
        guard let token = token.getUserToken().success else { return }
        
        //LLAMAR AL INTERACTOR
        self.interactor?.interactorGetData(token: token)
        //self.view?.startActivity()
    }
    
    // GET NUMBER OF SECTION
    func numberOfSections() -> Int {
        return 1
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
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
    
    /*
     func showPost(post: Post) {
         self.wireFrame?.gotoPostScreen(from: view!, post: post)
     }
     */
    func gotoPostScreen(post: Post?) {
        self.wireFrame?.navigateToPost(from: view!, post: post)
    }
}



// MARK: - OUT PUT
extension SearchPresenter: SearchInteractorOutputProtocol {
    
    // MARK: FUNCTIONS
    
    // EL PRESENTER RECIBE LOS DATOS DEL INTERACTOR
    func interactorCallBackData(userpost: [Post]) {
        self.viewModel = userpost
        view?.stopActivity()
    }
}
