//
//  PicInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 10/10/22.
//  
//

import Foundation

class PicInteractor: PicInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PicInteractorOutputProtocol?
    var localDatamanager: PicLocalDataManagerInputProtocol?
    var remoteDatamanager: PicRemoteDataManagerInputProtocol?

}

extension PicInteractor: PicRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
