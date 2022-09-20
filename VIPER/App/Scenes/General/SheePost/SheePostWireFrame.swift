//
//  SheePostWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/9/22.
//  
//

import Foundation
import UIKit

class SheePostWireFrame: SheePostWireFrameProtocol {
  
    
    class func createSheePostModule(post: Post?) -> UIViewController {
        let SheePost = SheePostView()
        let viewController = SheePost
        let presenter: SheePostPresenterProtocol & SheePostInteractorOutputProtocol = SheePostPresenter()
        let interactor: SheePostInteractorInputProtocol & SheePostRemoteDataManagerOutputProtocol = SheePostInteractor()
        let localDataManager: SheePostLocalDataManagerInputProtocol = SheePostLocalDataManager()
        let remoteDataManager: SheePostRemoteDataManagerInputProtocol = SheePostRemoteDataManager()
        let wireFrame: SheePostWireFrameProtocol = SheePostWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.postReceivedFromPost = post
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    

    func sendDataPost(from view: SheePostViewProtocol, delete: Bool)  {
    }
    
    func navigateToPost(post: Post?, from view: SheePostViewProtocol) {
        
        //let cv = PostWireFrame.createPostModule(post: post) as? PostView
        
               
    }
}
