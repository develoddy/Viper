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
    
    // LLAMAR AL API REST PARA TRAER TODAS LAS PUBLICACIONES.
    func remoteGetData(token: String) {
        apiService.getUserPost( token: token ) { [ weak self ] ( result ) in
            switch result {
            case .success( let listOf ):
                guard let post = listOf.resPostImages?.posts else {
                    return
                }
                // LLAMAR AL INTERACTOR PARA DEVOLVER LOS DATOS
                self?.remoteRequestHandler?.remoteCallBackData(userpost: post)
            case .failure(let error):
                print("Error processing data Profile \(error)")
            }
        }
    }
}
