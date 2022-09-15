//
//  HomeProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: HomePresenterProtocol? { get set }
    var page: Int! { get set }
    func updateUIList()
    func startActivity()
    func stopActivity()
    func stateHeart(heart: Heart, post: Post)
}

protocol HomeWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createHomeModule() -> UIViewController
    func navigateToProfile(from view: HomeViewProtocol, id: Int, name: String, token: String)
    func navigateToComments(from view: HomeViewProtocol, userpost: Post)
}

protocol HomePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    var heart: [Heart]? { get set }
    var totalPages: Int! {get set}
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func cellForRowAt(at index: Int) -> HomeFeedRenderViewModel
    func createLike(post: Post?)
    func deleteLike(heart: Heart?)
    func getIdentity() -> UserLogin?
    func checkIfLikesExist(post: Post?)
    func getTotalPages() -> Int
    func loadMoreData(page: Int)
    
    // CAMBIO DE PANTALLAS
    func gotoProfileScreen(id: Int, name: String, token: String)
    func gotoCommentsScreen(userpost: Post)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel], totalPages: Int)
    func interactorCallBackLikesExist(with heart: [Heart], post: Post?)
    func interactorCallBackDeleteLike(with message: ResMessage)
    func interactorCallBackInsertLike(with heart: Heart)
}

protocol HomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    func interactorGetData(page: Int, isPagination:Bool, token: String)
    func interactorCreateLike(post: Post?, userId: Int, token: String)
    func interactorDeleteLike(heart: Heart?, token: String)
    func interactorCheckIfLikesExist(postId: Int, userId: Int, token: String, post: Post?)
}

protocol HomeDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    var isPaginationOn: Bool? { get set }
    func remoteGetData(page: Int, isPagination:Bool, token: String)
    func remoteCreateLike(post: Post?, userId:Int, token: String)
    func remoteDeleteLike(heart: Heart?, token: String)
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: Post?)
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel], totalPages: Int)
    func remoteCallBackLikesExist(with heart: [Heart], post: Post?)
    func remoteCallBackInsertLike(with heart: Heart)
    func remoteCallBackDeleteLike(with message: ResMessage)
}

protocol HomeLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
