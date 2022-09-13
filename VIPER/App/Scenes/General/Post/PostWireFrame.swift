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
   
    class func createPostModule(post: Post?) -> UIViewController {
        let postView = PostView()
        let viewController = postView
        let presenter: PostPresenterProtocol & PostInteractorOutputProtocol = PostPresenter()
        let interactor: PostInteractorInputProtocol & PostRemoteDataManagerOutputProtocol = PostInteractor()
        let localDataManager: PostLocalDataManagerInputProtocol = PostLocalDataManager()
        let remoteDataManager: PostRemoteDataManagerInputProtocol = PostRemoteDataManager()
        let wireFrame: PostWireFrameProtocol = PostWireFrame()
            
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.userpostReceivedFromProfile = post
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return viewController
    }
    
    
    func navigateToComments(from view: PostViewProtocol, post: Post) {
        let newListcommentsView = CommentsWireFrame.createCommentsModule(userpost: post)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newListcommentsView, animated: true)
        }
    }
}
