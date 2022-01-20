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
    
    func presenterNumberOfSections() -> Int {
        return 3 //self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        if self.viewModel.count != 0 {
            return viewModel.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Userpost {
        return viewModel[indexPath.row]
    }
    
    func fetchUsername(indexPath: IndexPath) -> User? {
        let user = viewModel[indexPath.row].userAuthor
        return user
    }
    
}


// MARK: - OUTPUT
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    // RECIBE DATOS DEL INTERACTROR
    func interactorCallBackData(with viewModel: [Userpost]) {
        self.viewModel = viewModel
        view?.stopActivity()
        //print("Presenter")
        //print(self.viewModel )
    }
}
