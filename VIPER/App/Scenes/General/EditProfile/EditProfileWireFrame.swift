//
//  EditProfileWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 30/8/22.Edit
//  
//

import Foundation
import UIKit

class EditProfileWireFrame: EditProfileWireFrameProtocol {

    class func createEditProfileModule(model: UserViewData? /*User?*/) -> UIViewController {
        
        let editProfileView = EditProfileView() 
        
        let viewController = editProfileView
        let presenter: EditProfilePresenterProtocol & EditProfileInteractorOutputProtocol = EditProfilePresenter()
        let interactor: EditProfileInteractorInputProtocol & EditProfileRemoteDataManagerOutputProtocol = EditProfileInteractor()
        let localDataManager: EditProfileLocalDataManagerInputProtocol = EditProfileLocalDataManager()
        let remoteDataManager: EditProfileRemoteDataManagerInputProtocol = EditProfileRemoteDataManager()
        let wireFrame: EditProfileWireFrameProtocol = EditProfileWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        presenter.userReceivedFromProfile = model
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "EditProfileView", bundle: Bundle.main)
    }
    
}
