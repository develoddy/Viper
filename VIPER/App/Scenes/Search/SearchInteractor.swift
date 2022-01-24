//
//  SearchInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?

}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
