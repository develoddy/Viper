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
    func startActivity()
    func stopActivity() 
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
    func showHeaderCommentData() -> Post
    func insertComment(textComment: String)
    func fetchMoreData()
    func deleteRow(indexPath: IndexPath)
    func updateComment(indexPath: IndexPath, content: String)
}

protocol CommentsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with comment: [Comment])
    func interactorCallBackDeleteComment(with delete: Bool)
    func interactorCallBackListComments(with comments: [Comment])
    func interactorCallBackUpdateComment(with update: [Int])
}

protocol CommentsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CommentsInteractorOutputProtocol? { get set }
    var localDatamanager: CommentsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CommentsRemoteDataManagerInputProtocol? { get set }
    func interactorSetComment(pagination: Bool, commentPost: CommentPost?, token: String)
    func interactorReadByComment(idPost: Int, pagination:Int, token:String)
    func interactorDeleteComment(id: Int, token:String)
    func interactorUpdateComment(idPost: Int, idComment: Int, content: String, token:String)
}

protocol CommentsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CommentsRemoteDataManagerOutputProtocol? { get set }
    var isPagination : Bool  { get set }
    func remoteSetComment(pagination: Bool, commentPost: CommentPost?, token: String )
    func remoteReadByComment(idPost: Int, pagination:Int, token:String)
    func remoteDeleteComment(id: Int, token:String)
    func remoteUpdateComment(idPost: Int, idComment: Int, content: String, token:String)
}

protocol CommentsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with comment: [Comment])
    func remoteCallBackDeleteComment(with delete: Bool)
    func remoteCallBackListComments(with comments: [Comment])
    func remoteCallBackUpdateComment(with update: [Int])
    
}

protocol CommentsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CommentsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
