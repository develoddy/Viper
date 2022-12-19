import Foundation

class SearchResultRemoteDataManager:SearchResultRemoteDataManagerInputProtocol {
    
    // MARK:  PROPIERTIES
    var remoteRequestHandler: SearchResultRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    var viewModel: [User] = []
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    
    func remoteGetData(token: String, filter: String) {
        self.apiManager.filterSearch(token: token, filter: filter) { [weak self] result in
            switch result {
            case .success(let response):
                if let user = response {
                    self?.remoteRequestHandler?.remoteCallBackData(user: user)
                }
            case .failure(let error):
                print("Error processing data Search user \(error)")
            }
        }
    }
}
