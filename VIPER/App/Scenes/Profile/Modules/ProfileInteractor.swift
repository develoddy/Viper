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


// TODO: OUTPUT
extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    
    // TODO: RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func remoteCallBackData(with viewModel: [Userpost]) {
        // TODO: ENVIA DE VUELTA LOS DATOS AL PRESENTER
        self.presenter?.interactorCallBackData(with: viewModel)
    }
}
