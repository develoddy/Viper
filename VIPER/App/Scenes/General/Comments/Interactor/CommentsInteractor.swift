
import Foundation

class CommentsInteractor: CommentsInteractorInputProtocol {
    
    // MARK: PROPERTIES
    weak var presenter: CommentsInteractorOutputProtocol?
    var localDatamanager: CommentsLocalDataManagerInputProtocol?
    var remoteDatamanager: CommentsRemoteDataManagerInputProtocol?
    
    func interactorReadByComment(idPost: Int, pagination: Int, token: String) {
        self.remoteDatamanager?.remoteReadByComment(idPost: idPost, pagination: pagination, token: token)
    }
    
    func interactorSetComment(pagination: Bool, commentPost: CommentPost?, token: String) {
        self.remoteDatamanager?.remoteSetComment(pagination: pagination, commentPost: commentPost, token: token)
    }
    
    func interactorDeleteComment(id: Int, token: String) {
        self.remoteDatamanager?.remoteDeleteComment(id: id, token: token)
    }
    
    func interactorUpdateComment(idPost: Int, idComment: Int, content: String, token: String) {
        self.remoteDatamanager?.remoteUpdateComment(idPost: idPost, idComment: idComment, content: content, token: token)
    }
}


// MARK: - OUTPUT
extension CommentsInteractor: CommentsRemoteDataManagerOutputProtocol {
    
    func remoteCallBackListComments(with comments: [Comment]) {
        self.presenter?.interactorCallBackListComments(with: comments)
    }
    
    func remoteCallBackData(with comment: [Comment]) {
        self.presenter?.interactorCallBackData(with: comment)
    }
    
    func remoteCallBackDeleteComment(with delete: Bool) {
        self.presenter?.interactorCallBackDeleteComment(with: delete)
    }
    
    func remoteCallBackUpdateComment(with update: [Int]) {
        self.presenter?.interactorCallBackUpdateComment(with: update)
    }
}
