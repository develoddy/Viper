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
   
    // MARK:  PROPERTIES
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
    var idReceivedFromHome: Int?
    //var emailReceivedFromHome: String?
    var nameReceivedFromHome: String?
    var tokenReceivedFromHome: String?
    
    // MARK: CLOSURES
    var viewModelPost: [Post] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    var viewModel: [User] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    var viewModelTasts: [ResCounter] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    
    // MARK: - FUNCTIONS
    
    // LOS DATOS QUE LLEGAN DEL MODULO HOMEVIEW SE LO PASAMOS AL INTERACTOR
    func viewDidLoad() {
        
        guard let id = idReceivedFromHome, let token = tokenReceivedFromHome else {
            return
        }
        
        self.interactor?.interactorGetData(id: id, token: token)
        self.interactor?.interactorGetCounter(id: id, token: token)
        self.interactor?.interactorGetPosts(id: id, page: 0, token: token)
        self.view?.startActivity()
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return 3
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        /*if self.viewModel.count != 0 {
            return viewModel.count
        }
        return 0*/
        
        if self.viewModelPost.count != 0 {
            return viewModelPost.count
        }
        return 0
    }
    
    // GET DATA
    //func showProfileData(indexPath: IndexPath) -> Post {
    func showPostsData(indexPath: IndexPath) -> Post? {
        //return viewModel[indexPath.row]
        return viewModelPost[indexPath.row]
    }
    
    // GET USER
    func username() -> User? {
        let userpost = self.viewModel.last
        return userpost
    }
    
    func tasts() -> ResCounter? {
        let tasts = self.viewModelTasts.last
        return tasts
    }
    
    // GOTO POST
    func showPost(post: Post) {
        self.wireFrame?.gotoPostScreen(from: view!, post: post)
    }
}


// MARK: - OUTPUT
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    // RECIBE DE VUELTA LOS DATOS DEL INTERACTROR
    func interactorCallBackData(with viewModel: [User]) {
        self.viewModel = viewModel
        self.view?.stopActivity()
    }
    
    // RECIBE DE VUELTA LOS DATOS DE LOS COUNTER EL USUARIO
    func interactorCallBackTasts(with viewModel: [ResCounter]) {
        self.viewModelTasts = viewModel
        self.view?.stopActivity()
    }
    
    // RECIBE DE VUELTA LOS DATOS DE LOS COUNTER EL USUARIO
    func interactorCallBackPosts(with viewModel: [Post]) {
        self.viewModelPost = viewModel
        
        self.view?.stopActivity()
    }
    
}
