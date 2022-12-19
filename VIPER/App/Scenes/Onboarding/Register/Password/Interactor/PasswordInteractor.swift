//
//  PasswordInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 10/10/22.
//  
//

import Foundation

class PasswordInteractor: PasswordInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PasswordInteractorOutputProtocol?
    var localDatamanager: PasswordLocalDataManagerInputProtocol?
    var remoteDatamanager: PasswordRemoteDataManagerInputProtocol?

}

extension PasswordInteractor: PasswordRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
