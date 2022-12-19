//
//  ChatInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/12/22.
//  
//

import Foundation

class ChatInteractor: ChatInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ChatInteractorOutputProtocol?
    var localDatamanager: ChatLocalDataManagerInputProtocol?
    var remoteDatamanager: ChatRemoteDataManagerInputProtocol?

}

extension ChatInteractor: ChatRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
