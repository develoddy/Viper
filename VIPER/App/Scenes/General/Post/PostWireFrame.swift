//
//  PostWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//  
//

import Foundation
import UIKit

class PostWireFrame: PostWireFrameProtocol {

    class func createPostModule(userpost: Userpost) -> UIViewController {
        let navController = PostView()
        let viewController = navController
        let presenter: PostPresenterProtocol & PostInteractorOutputProtocol = PostPresenter()
        let interactor: PostInteractorInputProtocol & PostRemoteDataManagerOutputProtocol = PostInteractor()
        let localDataManager: PostLocalDataManagerInputProtocol = PostLocalDataManager()
        let remoteDataManager: PostRemoteDataManagerInputProtocol = PostRemoteDataManager()
        let wireFrame: PostWireFrameProtocol = PostWireFrame()
            
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.userpostReceivedFromProfile = userpost
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return navController
    }
}
