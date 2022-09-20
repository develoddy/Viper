//
//  SheetHomePostsWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/9/22.
//  
//

import Foundation
import UIKit

class SheetHomePostsWireFrame: SheetHomePostsWireFrameProtocol {

    class func createSheetHomePostsModule(post: Post?) -> UIViewController {
        
        let SheetHomePosts = SheetHomePostsView()
        let viewController = SheetHomePosts
        let presenter: SheetHomePostsPresenterProtocol & SheetHomePostsInteractorOutputProtocol = SheetHomePostsPresenter()
        let interactor: SheetHomePostsInteractorInputProtocol & SheetHomePostsRemoteDataManagerOutputProtocol = SheetHomePostsInteractor()
        let localDataManager: SheetHomePostsLocalDataManagerInputProtocol = SheetHomePostsLocalDataManager()
        let remoteDataManager: SheetHomePostsRemoteDataManagerInputProtocol = SheetHomePostsRemoteDataManager()
        let wireFrame: SheetHomePostsWireFrameProtocol = SheetHomePostsWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.postReceivedFromHome = post
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
}
