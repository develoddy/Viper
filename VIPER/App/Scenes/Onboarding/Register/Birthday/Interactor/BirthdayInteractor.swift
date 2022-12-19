//
//  BirthdayInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 10/10/22.
//  
//

import Foundation

class BirthdayInteractor: BirthdayInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: BirthdayInteractorOutputProtocol?
    var localDatamanager: BirthdayLocalDataManagerInputProtocol?
    var remoteDatamanager: BirthdayRemoteDataManagerInputProtocol?

}

extension BirthdayInteractor: BirthdayRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
