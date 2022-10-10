import Foundation

// MARK: REMOTE MANAGER
class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    // MARK: PROPERTIES
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    //let apiService: APIServiceProtocol
    let apiManager: ProAPIManagerProtocol

    // MARK: CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    /* TODO: LLAMAR AL API MANAGER
     * EN ESTE PUNTO SE LLAMA AL API MANAGER PARA OBTENER LOS DATOS DEL USUARIO. */
    func remoteGetData(email: String?, password: String? ) {
        APIManager.shared.fetchLogin(email: email, password: password) {[weak self] (result) in
            switch result {
            case .success(let response):
                if let login = response {
                    if login.success != nil {
                        ApiSession.shared.saveSesion(deUsuario: login)
                        self?.remoteRequestHandler?.remoteCallBackData(success: true)
                    } else {
                        self?.remoteRequestHandler?.remoteLoginFailed()
                    }
                }
            case .failure(let error): print("Error processing  data Login \(error)")
            }
        }
    }
}
