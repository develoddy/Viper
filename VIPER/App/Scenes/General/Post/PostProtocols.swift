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
}

protocol PostWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createPostModule(post: Post?) -> UIViewController
}

protocol PostPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PostViewProtocol? { get set }
    var interactor: PostInteractorInputProtocol? { get set }
    var wireFrame: PostWireFrameProtocol? { get set }
    var userpostReceivedFromProfile: Post? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func cellForRowAt(at index: IndexPath) -> PostRenderViewModel
}

protocol PostInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(userPost: [PostRenderViewModel])
}

protocol PostInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PostInteractorOutputProtocol? { get set }
    var localDatamanager: PostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PostRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(userpost: Post) 
}

protocol PostDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol PostRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PostRemoteDataManagerOutputProtocol? { get set }
}

protocol PostRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol PostLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
