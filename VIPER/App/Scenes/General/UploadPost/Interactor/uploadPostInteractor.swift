//
//  uploadPostInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/22.
//  
//

import Foundation

class uploadPostInteractor: uploadPostInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: uploadPostInteractorOutputProtocol?
    var localDatamanager: uploadPostLocalDataManagerInputProtocol?
    var remoteDatamanager: uploadPostRemoteDataManagerInputProtocol?

}

extension uploadPostInteractor: uploadPostRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
