//
//  LoginRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation

class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    
    // MARK: - Closures
    // Through these closures, our view model will execute code while some events will occure
    // They will be set up by the view controller
    var reloadTableViewClosure      : (()->())?
    var showAlertClosure            : (()->())?
    var updateLoadingStatusClosure  : (()->())?
    
    // MARK: - Properties
        
    // We defined the FakeAPIServiceProtocol in the APIService.swift file.
    // We also defined a class and make it conform to that protocol.
    let apiService: APIServiceProtocol
    
    // This will contain info about the picture eventually selectded by the user by tapping an item on the screen
    var selectedHome: HomeFeedRenderViewModel?
    
    // The collection that will contain our fetched data
    //var success: [Bool] = [Bool]() {
    //    didSet {
    //        self.reloadTableViewClosure?()
    //    }
    // }
    
    var success: Bool = false
    
    // A property containing the number ot items, it will be used by the view controller to render items on the screen using a
    var numberOfItems: Bool {
        return success
    }
    
    // The collection that will contain our fetched data
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    // MARK: Token
    // Initialize the Token App.
    private var token = Token()
    
    
    
    // MARK: - Constructor
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // LLAMAR AL SERVICIO Y OBTENER LOS DATOS
    func remoteGetData(email: String?, password: String?) {
        //self.isLoading = true
        apiService.login(email: email, password: password) { [weak self] success in
            // ENVIAR DE VUELTA LOS DATOS AL INTERACTOS
            self?.remoteRequestHandler?.remoteCallBackData(success: success)
        }
        //self.isLoading = false
    }
}
