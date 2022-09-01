//
//  ListPeopleWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 31/8/22.
//  
//

import Foundation
import UIKit

class ListPeopleWireFrame: ListPeopleWireFrameProtocol {

    class func createListPeopleModule(following: [Follow], token: LoginToken? ) -> UIViewController {
        
        let listPeopleView = ListPeopleView()
        let viewController = listPeopleView
        let presenter: ListPeoplePresenterProtocol & ListPeopleInteractorOutputProtocol = ListPeoplePresenter()
        let interactor: ListPeopleInteractorInputProtocol & ListPeopleRemoteDataManagerOutputProtocol = ListPeopleInteractor()
        let localDataManager: ListPeopleLocalDataManagerInputProtocol = ListPeopleLocalDataManager()
        let remoteDataManager: ListPeopleRemoteDataManagerInputProtocol = ListPeopleRemoteDataManager()
        let wireFrame: ListPeopleWireFrameProtocol = ListPeopleWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.loginTokenReceivedFromProfile = token
        presenter.followingReceivedFromProfile = following
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
}
