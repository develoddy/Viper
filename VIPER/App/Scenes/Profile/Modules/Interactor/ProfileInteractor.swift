//
//  ProfileInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation

// MARK: INPUT
class ProfileInteractor: ProfileInteractorInputProtocol {
    
    // MARK: - PROPERTIES
    weak var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?
    
    
    // MARK: LLAMAMOS AL REMOTE MANAGER
    func interactorGetData(email: String, token: String) {
        self.remoteDatamanager?.remoteGetData(email: email, token: token)
    }
}


// MARK: OUTPUT
extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    
    // RECIBE DATOS DEL REMOTE DATA MANAGER
    func remoteCallBackData(with viewModel: [Userpost]) {
        // ENVIA LOS DATOS AL PRESENTER
        self.presenter?.interactorCallBackData(with: viewModel)
    }
}
