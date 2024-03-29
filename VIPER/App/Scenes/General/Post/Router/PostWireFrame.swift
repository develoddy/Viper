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
    
    class func createPostModule(post: PostViewData?, indexPath: IndexPath) -> UIViewController {
        
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
        presenter.indexPathReceivedFromProfile = indexPath
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return viewController
    }
    
    
    func navigateToComments(from view: PostViewProtocol, post: PostViewData) {
        let newListcommentsView = CommentsWireFrame.createCommentsModule(userpost: post)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newListcommentsView, animated: true)
        }
    }
    
    func navigateSheePostView(from view: PostViewProtocol, post: PostViewData, indexPath: IndexPath) {
        let newSheePostView = SheePostWireFrame.createSheePostModule(post: post, indexPath: indexPath)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.present(newSheePostView, animated: true, completion: nil)
        }
    }
    
}
