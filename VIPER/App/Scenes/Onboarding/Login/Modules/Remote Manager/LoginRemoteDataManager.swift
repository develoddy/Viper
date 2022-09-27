//
//  LoginRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation

class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    // MARK:  PROPERTIES
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    //let apiService: APIServiceProtocol
    let apiManager: ProAPIManagerProtocol

    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    // LLAMAR AL SERVICIO Y OBTENER LOS DATOS.
    func remoteGetData(email: String?, password: String? ) {
        /*apiService.login( email: email, password: password ) { success in
           self.remoteRequestHandler?.remoteCallBackData( success: success )
        }*/
        
        guard let email = email, let password = password else {
            return
        }
        
        APIManager.shared.fetchLogin(email: email, password: password) {[weak self] response in
            if let _ = response?.success  {
                DispatchQueue.main.async {
                    guard let userLogin = response else {
                        return
                    }
                    APIManager.shared.saveSesion(deUsuario: userLogin)
                }
                self?.remoteRequestHandler?.remoteCallBackData(success: true)
            } else {
                // POSIBLE ERROR.
                self?.remoteRequestHandler?.remoteLoginFailed()
            }
        }
    }
}
