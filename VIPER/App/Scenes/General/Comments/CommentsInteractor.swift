//
//  CommentsInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class CommentsInteractor: CommentsInteractorInputProtocol {
    
    // MARK: PROPERTIES
    weak var presenter: CommentsInteractorOutputProtocol?
    var localDatamanager: CommentsLocalDataManagerInputProtocol?
    var remoteDatamanager: CommentsRemoteDataManagerInputProtocol?
    
    func interactorSetComment(pagination: Bool, commentPost: CommentPost?, token: String) {
        self.remoteDatamanager?.remoteSetComment(pagination: pagination, commentPost: commentPost, token: token)
    }

}


// MARK: - OUTPUT
extension CommentsInteractor: CommentsRemoteDataManagerOutputProtocol {
    
    
    // TODO: Implement use case methods
    func remoteCallBackData(with comment: [Comment]) {
        self.presenter?.interactorCallBackData(with: comment)
    }
    
    
}
