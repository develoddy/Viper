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

    class func createListPeopleModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ListPeopleView")
        if let view = navController.children.first as? ListPeopleView {
            let presenter: ListPeoplePresenterProtocol & ListPeopleInteractorOutputProtocol = ListPeoplePresenter()
            let interactor: ListPeopleInteractorInputProtocol & ListPeopleRemoteDataManagerOutputProtocol = ListPeopleInteractor()
            let localDataManager: ListPeopleLocalDataManagerInputProtocol = ListPeopleLocalDataManager()
            let remoteDataManager: ListPeopleRemoteDataManagerInputProtocol = ListPeopleRemoteDataManager()
            let wireFrame: ListPeopleWireFrameProtocol = ListPeopleWireFrame()
            
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
        return UIStoryboard(name: "ListPeopleView", bundle: Bundle.main)
    }
    
}
