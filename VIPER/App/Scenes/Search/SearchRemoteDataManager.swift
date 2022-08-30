//
//  SearchRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class SearchRemoteDataManager:SearchRemoteDataManagerInputProtocol {
    
    // MARK: - PROPERTIES
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    let apiService: APIServiceProtocol
    
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK: - FUNCTIONS
    
    // LLAMAR AL API REST
    func remoteGetData(token: String) {
        /*apiService.getUserPost(token: token) { [ weak self ] ( result ) in
            switch result {
            case .success( let listOf ):
                guard let userpost = listOf.userpost else {
                    return
                }
                // LLAMAR AL INTERACTOR PARA DEVOLVER LOS DATOS
                self?.remoteRequestHandler?.remoteCallBackData(userpost: userpost)
            case .failure(let error):
                print("Error processing data Profile \(error)")
            }
        }*/
    }
}
