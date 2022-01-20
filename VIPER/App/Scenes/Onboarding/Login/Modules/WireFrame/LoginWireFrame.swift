//
//  LoginWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {

    class func createLoginModule() -> UIViewController {
        let loginView = LoginView()
        let viewController = loginView
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return viewController
    }
    
    // MARK: - SE ENCARGA DE NAVERGAR AL TAB BAR CONTROLLER.
    func presentNewTabBarController() {
        //print("LoginWireFrame devuelta  Login Success - Cambio a tabBarControllER !!!")
        
        let submodules = (
            home: HomeWireFrame.createHomeModule(),
            profile: ProfileWireFrame.createProfileModule()
        )
        
        let tabBarController = TabBarModuleBuilder.build(usingSubmodules: submodules)
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let obj = appDelegate.objUsuarioSesion
        let token = obj?.token
        
        if token != nil {
            //print("LoginWireFrame - Si Hay token")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
        } else {
            //print("LoginWireFrame -  No hay token")
        }
        
    }
    
}
