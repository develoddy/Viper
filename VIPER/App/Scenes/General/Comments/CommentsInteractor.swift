//
//  CommentsInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class CommentsInteractor: CommentsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CommentsInteractorOutputProtocol?
    var localDatamanager: CommentsLocalDataManagerInputProtocol?
    var remoteDatamanager: CommentsRemoteDataManagerInputProtocol?

}

extension CommentsInteractor: CommentsRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
