//
//  ProfileRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation

// MARK: REMOTE DATA MANAGER
class ProfileRemoteDataManager:ProfileRemoteDataManagerInputProtocol {
    
    // MARK: PROPERTIES
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    let apiService: APIServiceProtocol
    var viewModel: [Userpost] = []
    var user: User?
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - FUNCTIONS
    func remoteGetData(email: String, token: String) {
        apiService.getProfile(email: email, token: token) { [ weak self ] ( result ) in
            switch result {
            case .success( let listOf ):
                guard let viewModel = listOf.userpost else {
                    return
                }
                self?.viewModel = viewModel
                
                // TODO: ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                self?.remoteRequestHandler?.remoteCallBackData(with: self?.viewModel ?? [])
                
            case .failure(let error):
                print("Error processing data Profile \(error)")
            }
        }
    }
    
}
