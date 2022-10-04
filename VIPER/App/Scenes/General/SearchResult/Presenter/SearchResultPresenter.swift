//
//  SearchResultPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//  
//

import Foundation
import UIKit

class SearchResultPresenter: SearchResultPresenterProtocol  {
    
    // MARK: - PROPERTIES
    weak var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorInputProtocol?
    var wireFrame: SearchResultWireFrameProtocol?
    var filter: String?
    var delegate: SearchResultPresenter?
    var token = Token()
    var viewModel: [User] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    // TODO: FUNCTIONS
    func viewDidLoad() {
        guard let filter = filter, let token = token.getUserToken().success else { return }
        self.interactor?.interactorGetData(token: token, filter: filter)
        self.view?.startActivity()
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        self.viewModel.count
    }
    
    func showProfileData(indexPath: IndexPath) -> User {
        return self.viewModel[indexPath.row]
    }
    
    func viewModelIsEmpty() -> Bool {
        return self.viewModel.isEmpty
    }
    
    // SE LLAMA AL WIREGRAME
    func showPost(user: User) {
        guard let id = user.id, let name = user.name, let token = token.getUserToken().success else { return }
        self.wireFrame?.navigateToProfile(from: view!, id: id, name: name, token: token)
    }
}



// TODO: - OUTPUT
extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    
    // TODO: RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func interactorCallBackData(user: [User]) {
        self.viewModel = user
        self.view?.stopActivity()
    }
}
