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
    
    var viewModel: [Userpost] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
}


// MARK: - FUNCTIONS
extension SearchPresenter: SearchPresenterProtocol {
    
    // TODO: -  FUNCTIONS
    
    func viewDidLoad() {
        guard let token = token.getUserToken().token else { return }
        // LLAMAR AL INTERACTOR
        self.interactor?.interactorGetData(token: token)
        self.view?.startActivity()
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
    func showUserpostData(indexPath: IndexPath) -> Userpost {
        return self.viewModel[indexPath.row]
    }
    
    // SEARCH FILTER
    func searchResultsUpdating(resultsComtroller: SearchResultView, filter: String) {
        // LLAMAR AL WIREFRAME
        self.wireFrame?.gotoSearchResultsUpdating(from: self.view!, resultsComtroller: resultsComtroller, filter: filter)
    }
}



// MARK: - OUT PUT
extension SearchPresenter: SearchInteractorOutputProtocol {
    
    // MARK: FUNCTIONS
    
    // EL PRESENTER RECIBE LOS DATOS DEL INTERACTOR
    func interactorCallBackData(userpost: [Userpost]) {
        self.viewModel = userpost
        view?.stopActivity()
    }
}
