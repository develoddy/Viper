//
//  CommentsProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit

protocol CommentsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CommentsPresenterProtocol? { get set }
}

protocol CommentsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCommentsModule(userpost: Post?) -> UIViewController
}

protocol CommentsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CommentsViewProtocol? { get set }
    var interactor: CommentsInteractorInputProtocol? { get set }
    var wireFrame: CommentsWireFrameProtocol? { get set }
    
    var userpostReceivedFromHome: Post? { get set }
    
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showCommentsData(indexPath: IndexPath) -> Comment
    func showHeaderCommentData(section: Int) -> Post
}

protocol CommentsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol CommentsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CommentsInteractorOutputProtocol? { get set }
    var localDatamanager: CommentsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CommentsRemoteDataManagerInputProtocol? { get set }
}

protocol CommentsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CommentsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CommentsRemoteDataManagerOutputProtocol? { get set }
}

protocol CommentsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CommentsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
