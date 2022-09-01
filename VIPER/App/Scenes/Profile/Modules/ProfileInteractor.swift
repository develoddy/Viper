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
        
        /*
         - ---------- LLAMAR AL REMOTEDATAMANAGER ------------
         - EN ESTE PUNTO ES DECISIVO PORQUE SEGUN EL USUARIO SI ELIJE
         - ENTRARAL PERFIL DESDEL EL HOME O DESDE TAB MANAGER.
         */
        if token.isEmpty {
            guard let id = self.token.getUserToken().user?.id else { return }
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetData(id: id, token: token)
        } else {
            self.remoteDatamanager?.remoteGetData(id: id, token: token)
        }
    }
    
    /*
     - ---------- LLAMAR AL REMOTEDATAMANAGER ------------
     - EN ESTE PUNTO SE OBTIENE LOS CONTADORES DE SEGUIDORES, PUBLICACIONES, ETC.
     */
    func interactorGetCounter(id: Int, token: String) {
        if token.isEmpty {
            guard let id = self.token.getUserToken().user?.id else { return }
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetCounter(id: id, token: token)
        } else {
            self.remoteDatamanager?.remoteGetCounter(id: id, token: token)
        }
    }
    
    /*
     - ---------- LLAMAR AL REMOTEDATAMANAGER ------------
     - EN ESTE PUNTO SE OBTIENE LAS PUBLICACIONES.
     */
    func interactorGetPosts(id: Int, page: Int, token: String) {
        if token.isEmpty {
            guard let id = self.token.getUserToken().user?.id else { return }
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetPosts(id: id, page: page, token: token)
        } else {
            self.remoteDatamanager?.remoteGetPosts(id: id, page: page, token: token)
        }
    }
    
    /*
     - ---------- LLAMAR AL REMOTEDATAMANAGER ------------
     - EN ESTE PUNTO SE OBTIENE LAS PUBLICACIONES.
     */
    func interactorGetFollowing(page: Int, token: String) {
        
        if token.isEmpty {
            guard let token = self.token.getUserToken().success else { return }
            self.remoteDatamanager?.remoteGetFollowing(page: page, token: token)
        } else {
            self.remoteDatamanager?.remoteGetFollowing(page: page, token: token)
        }
    }
    
}


// MARK: - OUTPUT

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    
    /*
     * ---------- LLAMAR AL PRESENTER ------------
     * RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER.
     * EN ESTE PUNTO SE ENVIA LOS DATOS (USER) AL PRESENTER.
     */
    func remoteCallBackData(with viewModel: [ User ]) {
        self.presenter?.interactorCallBackData( with: viewModel )
    }
    
    /*
     * ---------- LLAMAR AL PRESENTER ------------
     * RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER.
     * EN ESTE PUNTO SE ENVIA LOS DATOS (COUNTER) AL PRESENTER.
     */
    func remoteCallBackTasts(with viewModel: [ ResCounter ]) {
        self.presenter?.interactorCallBackTasts( with: viewModel )
    }
    
    /*
     * ---------- LLAMAR AL PRESENTER ------------
     * RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER.
     * EN ESTE PUNTO SE ENVIA LOS DATOS (POST) AL PRESENTER.
     */
    func remoteCallBackPosts( with viewModel: [ Post ] ) {
        self.presenter?.interactorCallBackPosts( with: viewModel )
    }
    
    /*
     * ---------- LLAMAR AL PRESENTER ------------
     * RECIBE LOS DATOS DE VUELTA DEL REMOTE DATA MANAGER.
     * EN ESTE PUNTO SE ENVIA LOS DATOS (FOLLOWING) AL PRESENTER.
     */
    func remoteCallBackFollowing(with viewModel: [Follow]) {
        self.presenter?.interactorCallBackFollowing(with: viewModel)
    }
    
}
