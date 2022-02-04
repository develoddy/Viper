//
//  ProfilePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import UIKit

// MARK: PRESENTER
class ProfilePresenter: ProfilePresenterProtocol  {
   
    // MARK: - PROPERTIES
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    var emailReceivedFromHome: String?
    var nameReceivedFromHome: String?
    var tokenReceivedFromHome: String?
    
    // MARK: CLOSURES
    var viewModel: [Userpost] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    
    // MARK: - FUNCTIONS
    
    // LOS DATOS QUE LLEGAN DEL MODULO HOMEVIEW SE LO PASAMOS AL INTERACTOR
    func viewDidLoad() {
        guard let email = emailReceivedFromHome, let token = tokenReceivedFromHome else {
            return
        }
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
    
    // GOTO POST
    func showPost(userpost: Userpost) {
        self.wireFrame?.gotoPostScreen(from: view!, userpost: userpost)
    }
}


// MARK: - OUTPUT
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    // TODO: RECIBE DE VUELTA LOS DATOS DEL INTERACTROR
    func interactorCallBackData(with viewModel: [Userpost]) {
        self.viewModel = viewModel
        self.view?.stopActivity()
    }
}
