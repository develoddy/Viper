//
//  SearchInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {
    
    // MARK: PROPERTIES
    weak var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    
    // MARK: FUNCTIONS
    
    // LLAMAR AL REMOTE DATA MANAGER
    func interactorGetData(token: String) {
        self.remoteDatamanager?.remoteGetData(token: token)
    }

}


// MARK: - OUPUT
extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    
    // MARK: FUNCTIONS
    
    // LLAMAR AL PRESENTER PARA DE VOLVER LOS DATOS
    func remoteCallBackData(userpost: [Userpost]) {
        self.presenter?.interactorCallBackData(userpost: userpost)
    }
}
