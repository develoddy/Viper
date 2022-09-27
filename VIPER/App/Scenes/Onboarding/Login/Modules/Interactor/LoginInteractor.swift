//
//  LoginInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation

// MARK: INTERACTOR
class LoginInteractor: LoginInteractorInputProtocol {
    
    // MARK: PROPERTIES
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func interactorGetData(email: String?,password: String?) {
        // DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER)
        // QUE TIENE QUE TRAER UNOS DATOS.
        remoteDatamanager?.remoteGetData(email: email, password: password )
    }
}


// MARK: INTERACTOR OutputProtocol
extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    
    // VALIDATE LOGIN "TRUE" OR "FALSE"
    // EL INTERACTOR DEBE ENVIARLE LOS DATOS AL PRESENTER.
    // EL INTERACTOR TIENE QUE ENVIAR LOS DATOS AL PRESENTER "MASTICADITO"
    func remoteCallBackData(success: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.interactorCallBackData(success: success)
        }
    }
    
    func remoteLoginFailed() {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.interactorLoginFailed()
        }
    }
}
