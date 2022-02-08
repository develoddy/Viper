//
//  SearchResultPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//  
//

import Foundation

class SearchResultPresenter: SearchResultPresenterProtocol  {
    
    // MARK: - PROPERTIES
    weak var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorInputProtocol?
    var wireFrame: SearchResultWireFrameProtocol?
    var filter: String?
    var token = Token()
    var viewModel: [Userpost] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    // TODO: FUNCTIONS
    func viewDidLoad() {
        guard let filter = filter, let token = token.getUserToken().token else { return }
        self.interactor?.interactorGetData(token: token, filter: filter)
        self.view?.startActivity()
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        self.viewModel.count
    }
    
    func showProfileData(indexPath: IndexPath) -> Userpost {
        return self.viewModel[indexPath.row]
    }
    
    
    func viewModelIsEmpty() -> Bool {
        return self.viewModel.isEmpty
    }
    
    func showPost(userpost: Userpost) {
        self.wireFrame?.gotoPostScreen(from: view!, userpost: userpost)
    }
}



// TODO: - OUTPUT
extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    
    // TODO: RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func interactorCallBackData(userpost: [Userpost]) {
        self.viewModel = userpost
        self.view?.stopActivity()
    }
}
