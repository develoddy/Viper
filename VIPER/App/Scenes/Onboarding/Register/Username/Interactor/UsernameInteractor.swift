//
//  UsernameInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 10/10/22.
//  
//

import Foundation

class UsernameInteractor: UsernameInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: UsernameInteractorOutputProtocol?
    var localDatamanager: UsernameLocalDataManagerInputProtocol?
    var remoteDatamanager: UsernameRemoteDataManagerInputProtocol?

}

extension UsernameInteractor: UsernameRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
