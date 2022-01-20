//
//  ProfilePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import UIKit

// MARK: PRESENTER
class ProfilePresenter  {
    
    // MARK: - Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
    // MARK: - Closures
    var viewModel: [Userpost] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
}

// MARK: - INPUT
extension ProfilePresenter: ProfilePresenterProtocol {
    
    // SE LLAMA AL INTERACTOR
    func viewDidLoad(email: String, token: String) {
        self.interactor?.interactorGetData(email: email, token: token)
        self.view?.startActivity()
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return 3
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        if self.viewModel.count != 0 {
            return viewModel.count
        }
        return 0
    }
    
    // GET DATA
    func showProfileData(indexPath: IndexPath) -> Userpost {
        return viewModel[indexPath.row]
    }
    
    // GET USER
    func username() -> User? {
        let userpost = self.viewModel.last
        return userpost?.userAuthor
    }
}


// MARK: - OUTPUT
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    // RECIBE DATOS DEL INTERACTROR
    func interactorCallBackData(with viewModel: [Userpost]) {
        self.viewModel = viewModel
        view?.stopActivity()
        //self.view?.displayDataProfile(with: viewModel)
    }
}
