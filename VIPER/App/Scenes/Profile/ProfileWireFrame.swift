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

    class func createProfileModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileView")
        if let view = navController.children.first as? ProfileView {
            let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
            let interactor: ProfileInteractorInputProtocol & ProfileRemoteDataManagerOutputProtocol = ProfileInteractor()
            let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()
            let remoteDataManager: ProfileRemoteDataManagerInputProtocol = ProfileRemoteDataManager()
            let wireFrame: ProfileWireFrameProtocol = ProfileWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "ProfileView", bundle: Bundle.main)
    }
    
}
