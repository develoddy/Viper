//
//  CommentsWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit

class CommentsWireFrame: CommentsWireFrameProtocol {
    class func createCommentsModule(userpost: Userpost?) -> UIViewController {
        let commentsView = CommentsView()
        let viewController = commentsView
        let presenter: CommentsPresenterProtocol & CommentsInteractorOutputProtocol = CommentsPresenter()
        let interactor: CommentsInteractorInputProtocol & CommentsRemoteDataManagerOutputProtocol = CommentsInteractor()
        let localDataManager: CommentsLocalDataManagerInputProtocol = CommentsLocalDataManager()
        let remoteDataManager: CommentsRemoteDataManagerInputProtocol = CommentsRemoteDataManager()
        let wireFrame: CommentsWireFrameProtocol = CommentsWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        // DATA QUE LLEGA DEL MODULO HOME
        presenter.userpostReceivedFromHome = userpost
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return viewController
    }
}
