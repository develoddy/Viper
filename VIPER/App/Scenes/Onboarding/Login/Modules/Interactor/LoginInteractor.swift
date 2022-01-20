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
    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func interactorGetData(email: String?, password: String?) {
        // DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER) QUE TIENE QUE TRAER UNOS DATOS
        remoteDatamanager?.remoteGetData(email: email, password: password)
    }
}


// MARK: INTERACTOR OutputProtocol
extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    
    // VALIDATE LOGIN "TRUE" OR "FALSE"
    // EL INTERACTOR DEBE ENVIARLE LOS DATOS AL PRESENTER.
    // EL INTERACTOR TIENE QUE ENVIAR LOS DATOS AL PRESENTER "MASTICADITO"
    func remoteCallBackData(success: Bool) {
        presenter?.interactorCallBackData(success: success)
        ///print("LoginInteractor devuelta Login Success !!! > \(success)")
    }
}
