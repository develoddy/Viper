//
//  LoginInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func interactorGetData(email: String?, password: String?) {
        // DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER) QUE TIENE QUE TRAER UNOS DATOS
        remoteDatamanager?.remoteGetData(email: email, password: password)
    }
}


// MARK: LoginRemoteDataManagerOutputProtocol
extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    
    func remoteCallBackData(success: Bool) {
        // EL INTERACTOS DEBE ENVIARLE LOS DATOS AL PRESENTER.
        print("devuelta LoginInteractor Login Success !!! > \(success)")
    }
}
