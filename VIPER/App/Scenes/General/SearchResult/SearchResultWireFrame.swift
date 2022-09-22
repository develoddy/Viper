//
//  SearchResultWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//  
//

import Foundation
import UIKit

class SearchResultWireFrame: SearchResultWireFrameProtocol {
    
    class func createSearchResultModule(filter: String) -> UIViewController {
        let searchResultView = SearchResultView()
        let viewController = searchResultView
        let presenter: SearchResultPresenterProtocol & SearchResultInteractorOutputProtocol = SearchResultPresenter()
        let interactor: SearchResultInteractorInputProtocol & SearchResultRemoteDataManagerOutputProtocol = SearchResultInteractor()
        let localDataManager: SearchResultLocalDataManagerInputProtocol = SearchResultLocalDataManager()
        let remoteDataManager: SearchResultRemoteDataManagerInputProtocol = SearchResultRemoteDataManager()
        let wireFrame: SearchResultWireFrameProtocol = SearchResultWireFrame()
        
        viewController.presenter                = presenter
        presenter.view                          = viewController
        presenter.wireFrame                     = wireFrame
        presenter.interactor                    = interactor
        presenter.filter                        = filter
        interactor.presenter                    = presenter
        interactor.localDatamanager             = localDataManager
        interactor.remoteDatamanager            = remoteDataManager
        remoteDataManager.remoteRequestHandler  = interactor
        
        return viewController
    }
        
    
    func navigateToProfile(from view: SearchResultViewProtocol, id: Int, name: String, token: String) {
        
        let newProfileView = ProfileWireFrame.createProfileModule(id: id, name: name, token: token, indexPath: [])
        newProfileView.title = "ProfileWireFrame"
       
        if let sourceView = view as? UIViewController {
           //sourceView.navigationController?.pushViewController(newProfileView, animated: true)
            //sourceView.present(newProfileView, animated: true)
            
            //let navigationController = UINavigationController( rootViewController: newProfileView )
            //navigationController.modalPresentationStyle = .fullScreen
            //sourceView.present( navigationController, animated: true )
            sourceView.navigationController?.pushViewController(newProfileView, animated: true)
        }
    }
}
