//
//  SearchResultInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//  
//

import Foundation

class SearchResultInteractor: SearchResultInteractorInputProtocol {
   
    // MARK: Properties
    weak var presenter: SearchResultInteractorOutputProtocol?
    var localDatamanager: SearchResultLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchResultRemoteDataManagerInputProtocol?
    
    func interactorGetData(token:String, filter: String) {
        if filter.isEmpty {
            print("El filter está vacio...")
        } else {
            self.remoteDatamanager?.remoteGetData(token: token, filter: filter)
        }
    }
}

// TODO: OUTPUT
extension SearchResultInteractor: SearchResultRemoteDataManagerOutputProtocol {
    // TODO: RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func remoteCallBackData(user: [User]) {
        self.presenter?.interactorCallBackData(user: user)
    }
    

}
