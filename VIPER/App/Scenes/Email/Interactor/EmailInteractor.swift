//
//  EmailInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/12/22.
//  
//

import Foundation

class EmailInteractor: EmailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: EmailInteractorOutputProtocol?
    var localDatamanager: EmailLocalDataManagerInputProtocol?
    var remoteDatamanager: EmailRemoteDataManagerInputProtocol?

}

extension EmailInteractor: EmailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
