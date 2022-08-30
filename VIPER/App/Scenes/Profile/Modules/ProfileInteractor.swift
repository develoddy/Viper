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
    func interactorGetData(id: Int, token: String) {
        
        if token.isEmpty {
            guard let id = self.token.getUserToken().user?.id else { return }
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetData(id: id, token: token)
        } else {
            self.remoteDatamanager?.remoteGetData(id: id, token: token)
        }
    }
    
    func interactorGetCounter(id: Int, token: String) {
        if token.isEmpty {
            guard let id = self.token.getUserToken().user?.id else { return }
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetCounter(id: id, token: token)
        } else {
            self.remoteDatamanager?.remoteGetCounter(id: id, token: token)
        }
    }
    
    func interactorGetPosts(id: Int, page: Int, token: String) {
        if token.isEmpty {
            guard let id = self.token.getUserToken().user?.id else { return }
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetPosts(id: id, page: page, token: token)
        } else {
            self.remoteDatamanager?.remoteGetPosts(id: id, page: page, token: token)
        }
    }
    
    
}


// TODO: OUTPUT
extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
  
    // RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func remoteCallBackData(with viewModel: [User]) {
        // ENVIA DE VUELTA LOS DATOS AL PRESENTER
        self.presenter?.interactorCallBackData(with: viewModel)
    }
    
    // RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func remoteCallBackTasts(with viewModel: [ResCounter]) {
        // ENVIA DE VUELTA LOS DATOS AL PRESENTER
        self.presenter?.interactorCallBackTasts(with: viewModel)
    }
    
    // RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER
    func remoteCallBackPosts(with viewModel: [Post]) {
        self.presenter?.interactorCallBackPosts(with: viewModel)
    }
    
    
}
