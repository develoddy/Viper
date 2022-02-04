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
    var token = Token()
    
    // MARK: LLAMAMOS AL REMOTE MANAGER
    func interactorGetData(email: String, token: String) {
        
        if email.isEmpty {
            guard let _token = self.token.getUserToken().token,
                  let _email = self.token.getUserToken().usertoken?.email else { return }
            self.remoteDatamanager?.remoteGetData(email: _email, token: _token)
        } else {
            self.remoteDatamanager?.remoteGetData(email: email, token: token)
        }
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
