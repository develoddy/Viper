//
//  ListPeopleInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 31/8/22.
//  
//

import Foundation

class ListPeopleInteractor: ListPeopleInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ListPeopleInteractorOutputProtocol?
    var localDatamanager: ListPeopleLocalDataManagerInputProtocol?
    var remoteDatamanager: ListPeopleRemoteDataManagerInputProtocol?

}

extension ListPeopleInteractor: ListPeopleRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
