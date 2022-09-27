//
//  PostProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//  
//

import Foundation
import UIKit

protocol PostViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PostPresenterProtocol? { get set }
    func updateUIList()
    func startActivity()
    func stopActivity()
    func stateHeart(heart: Heart, post: PostViewData)
    func dismissModule()
    func deletePost(post: PostViewData?)
}

protocol PostWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createPostModule(post: PostViewData?, indexPath: IndexPath) -> UIViewController
    func navigateToComments(from view: PostViewProtocol, post: PostViewData)
    func navigateSheePostView(from view: PostViewProtocol, post: PostViewData /*Post*/, indexPath: IndexPath)
}

protocol PostPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PostViewProtocol? { get set }
    var interactor: PostInteractorInputProtocol? { get set }
    var wireFrame: PostWireFrameProtocol? { get set }
    var userpostReceivedFromProfile: /*Post?*/ PostViewData? { get set }
    var indexPathReceivedFromProfile: IndexPath? { get set }
    
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func cellForRowAt(at index: IndexPath) -> PostRenderViewModel
    func getIdentity() -> UserLogin?
    func gotoCommentsScreen(post: PostViewData)
    func checkIfLikesExist(post: PostViewData?)
    // CRUD LIKE
    func createLike(post: PostViewData?)
    func deleteLike(heart: Heart?)
    func gotoSheePostView(post: PostViewData /*Post*/)
    func deletePost(post: PostViewData?)
    func getIndexPathReceivedFromProfile() -> IndexPath
    
}

protocol PostInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(userPost: [PostRenderViewModel])
    func interactorCallBackLikesExist(with heart: [Heart], post: PostViewData?)
    func interactorCallBackDeleteLike(with message: ResMessage)
    func interactorCallBackInsertLike(with heart: Heart)
}

protocol PostInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PostInteractorOutputProtocol? { get set }
    var localDatamanager: PostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PostRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(userpost: PostViewData /*Post*/)
    func interactorCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?)
    func interactorDeletePost(post: PostViewData?, token: String)
    
    // CRUD LIKE
    func interactorCreateLike(post: PostViewData?, userId: Int, token: String)
    func interactorDeleteLike(heart: Heart?, token: String)
}

protocol PostDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol PostRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PostRemoteDataManagerOutputProtocol? { get set }
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?)
    func remoteDeleteLike(heart: Heart?, token: String)
    
    // CRUD LIKE
    func remoteCreateLike(post: PostViewData?, userId:Int, token: String)
    
    // CRUD POST
    func remoteDeletePost(post: PostViewData?, token: String)
}

protocol PostRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackLikesExist(with heart: [Heart], post: PostViewData?)
    func remoteCallBackDeleteLike(with message: ResMessage)
}

protocol PostLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
