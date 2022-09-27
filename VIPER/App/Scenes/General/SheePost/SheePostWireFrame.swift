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
   
   
    class func createSheePostModule(post: /*Post?*/ PostViewData?, indexPath: IndexPath) -> UIViewController {
       
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
        
        presenter.indexPathReceivedFromProfile = indexPath
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    

    // DISMISS POST VIEW.
    func sendDataPost(from viewController: UIViewController, userId: Int, token: String, indexPath: IndexPath)  {
        let _ =  ProfileWireFrame.createProfileModule(id: userId, name: "sheepost", token: token, indexPath: indexPath)
        //view.viewDidLoad()

        let tran : CATransition = CATransition()
        tran.duration = 0.5
        tran.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        tran.type = CATransitionType.fade
        tran.subtype = CATransitionSubtype.fromTop
        viewController.view.window?.layer.add(tran, forKey: nil)
        viewController.dismiss(animated: true)
    }
    
    /*
     *
     */
    func gotoPost(from viewController: UIViewController, post: /*Post?*/ PostViewData?) {
        let _ =  PostWireFrame.createPostModule(post: post, indexPath: [])
        
        let tran : CATransition = CATransition()
        tran.duration = 0.5
        tran.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        tran.type = CATransitionType.fade
        tran.subtype = CATransitionSubtype.fromTop
        viewController.view.window?.layer.add(tran, forKey: nil)
        viewController.dismiss(animated: true)
    }
    
}
