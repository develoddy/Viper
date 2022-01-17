//
//  HomeWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation
import UIKit

class HomeWireFrame: HomeWireFrameProtocol {

    class func createHomeModule() -> UIViewController {
        
        //let navController = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
        let homeView = HomeView()
        
        // Esta condicion sirve para saber si el navigation controller tiene mas hijos controladores
        // if let view = navController.children.first as? HomeView {
        let viewController = homeView
            let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
            let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
            let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
            let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
            let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
            
            viewController.presenter                = presenter
            presenter.view                          = viewController
            presenter.wireFrame                     = wireFrame
            presenter.interactor                    = interactor
            interactor.presenter                    = presenter
            interactor.localDatamanager             = localDataManager
            interactor.remoteDatamanager            = remoteDataManager
            remoteDataManager.remoteRequestHandler  = interactor
            
            return viewController
        //}
        //return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "HomeView", bundle: Bundle.main)
    }
    
}
