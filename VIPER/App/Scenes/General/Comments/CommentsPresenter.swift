//
//  CommentsPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import CoreMIDI

/*
 enum PostRenderType {
     case header(provider: Post)
     case primaryContent(provider: Post)
     case actions(provider: Post)
     case descriptions(post: Post)
     case comments(comments: [Comment])
     case footer(footer: Post)
 }
 */

enum UserPostViewModelRenderType {
    //case primaryContent(posts: Post)
    case comments(comments: [Comment])
}

struct UserPostViewModelRenderViewModel {
    let renderType: UserPostViewModelRenderType
}


class CommentsPresenter : CommentsPresenterProtocol {
    
    // MARK: PROPERTIES.
    weak var view: CommentsViewProtocol?
    var interactor: CommentsInteractorInputProtocol?
    var wireFrame: CommentsWireFrameProtocol?
    var userpostReceivedFromHome: Post?
    private var commentPost: CommentPost?
    private var token = Token()
    
    // MARK: CLOSURES
    var renderModels: [UserPostViewModelRenderViewModel] = [] {
        didSet {
            self.view?.updateUI()
        }
    }

    // MEDIANTE EL WIREFRAME RECIBIMOS LOS DATOS QUE NOS ENVIA EL MODULO HOME (ACTION - COMMENTS)
    func viewDidLoad() {
        guard let comment = self.userpostReceivedFromHome?.comments else {
            return
        }
        renderModels.append(UserPostViewModelRenderViewModel(renderType: .comments(comments: comment )))
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return renderModels.count
       
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        switch renderModels[section].renderType {
        
        case .comments (let comments):
            return comments.count > 0 ? comments.count : comments.count
        }
    }
    
    // GET DATA COMMENTS.
    func showCommentsData(indexPath: IndexPath) -> Comment {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .comments(let comments):
            let comment = comments[indexPath.row]
            return comment
        
        }
    }
    
    // SHOW DATA HEADER.
    func showHeaderCommentData(section: Int) -> Post {
        guard let userPostViewModelModel = self.userpostReceivedFromHome else {
            fatalError("Error showCommentsData")
        }
        return userPostViewModelModel
        
    }
    
    func insertComment( textComment: String ) {
        self.commentPost = CommentPost(
            typeID: 0,
            refID: 0,
            user_id: 0,
            content: textComment,
            commentID: 0,
            createdAt: "2021-12-26 20:47:23",
            updatedAt: "2021-12-26 20:47:23",
            postID: userpostReceivedFromHome?.id ?? 0,
            userID: userpostReceivedFromHome?.user?.id ?? 0 )
        
        guard let token = token.getUserToken().success else {
            return
        }
        
        // LLAMAR AL INTERACTOR
        self.interactor?.interactorSetComment(pagination: false, commentPost: self.commentPost, token: token)
        
    }
    
    // FETCH MORE DATA.
    func fetchMoreData() {
    }
    
}



// MARK: - OUT PUT
extension CommentsPresenter: CommentsInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    func interactorCallBackData(with comment: [Comment]) {
        self.renderModels = []
        renderModels.append(UserPostViewModelRenderViewModel(renderType: .comments(comments: comment)))
    }
    
    
}
