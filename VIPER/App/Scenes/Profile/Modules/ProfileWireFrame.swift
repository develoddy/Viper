//
//  ProfileWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation
import UIKit

class ProfileWireFrame: ProfileWireFrameProtocol {
    
    static func createProfileModule(email: String, name: String, token: String) -> UIViewController {
  
        let profileView = ProfileView()
        let viewController = profileView
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
        let interactor: ProfileInteractorInputProtocol & ProfileRemoteDataManagerOutputProtocol = ProfileInteractor()
        let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()
        let remoteDataManager: ProfileRemoteDataManagerInputProtocol = ProfileRemoteDataManager()
        let wireFrame: ProfileWireFrameProtocol = ProfileWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        // DATOS QUE RECIBE DEL MODULO HOMEVIEW
        presenter.emailReceivedFromHome = email
        presenter.nameReceivedFromHome = name
        presenter.tokenReceivedFromHome = token 
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
    // GOTO POST
    func gotoPostScreen(from view: ProfileViewProtocol, userpost: Userpost) {
        let newPostView = PostWireFrame.createPostModule(userpost: userpost)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newPostView, animated: true)
        }
    }
}
