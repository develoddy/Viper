import Foundation

class NewMessageRemoteDataManager:NewMessageRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: NewMessageRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func remoteGetFollows(token: String?) {
        apiManager.fetchUsers(token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let follows = response?.follows {
                    // LLAMAR AL INTERACTOR
                    
                    self?.remoteRequestHandler?.remoteCallBackFollows(follows: follows)
                }
            case .failure(let error): print("Remote: Error processing profile like\(error)")
            }
        }
    }
    
}
