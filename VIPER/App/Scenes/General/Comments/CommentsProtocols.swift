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
    func updateUI()
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
    func insertComment(textComment: String)
    func fetchMoreData()
}

protocol CommentsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with comment: [Comment])
}

protocol CommentsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CommentsInteractorOutputProtocol? { get set }
    var localDatamanager: CommentsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CommentsRemoteDataManagerInputProtocol? { get set }
    func interactorSetComment(pagination: Bool, commentPost: CommentPost?, token: String )
}

protocol CommentsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CommentsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CommentsRemoteDataManagerOutputProtocol? { get set }
    func remoteSetComment(pagination: Bool, commentPost: CommentPost?, token: String )
    var isPagination : Bool  { get set }
}

protocol CommentsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with comment: [Comment])
    
}

protocol CommentsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
