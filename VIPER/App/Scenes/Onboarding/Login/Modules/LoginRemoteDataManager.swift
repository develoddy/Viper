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
    let apiService: APIServiceProtocol

    // MARK:  CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // LLAMAR AL SERVICIO Y OBTENER LOS DATOS.
    func remoteGetData(
        email: String?,
        password: String?
    ) {
        apiService.login( email: email, password: password ) { success in
           self.remoteRequestHandler?.remoteCallBackData( success: success )
        }
    }
}
