import Foundation

class SearchRemoteDataManager:SearchRemoteDataManagerInputProtocol {
    // MARK: PROPERTIES
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    var isPaginationOn: Bool? = false
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    

    // LLAMAR AL API REST PARA TRAER TODAS LAS PUBLICACIONES.
    func remoteGetData(page: Int, isPagination:Bool, token: String) {
        if isPagination {
            self.isPaginationOn = true
        }
        self.apiManager.fetchPosts(page: page, isPagination: isPagination, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let posts = response?.resPostImages?.posts, let totalPages = response?.resPostImages?.totalPages {
                    if isPagination {
                        self?.remoteRequestHandler?.remoteCallBackDataAppend(userpost: posts)
                            self?.isPaginationOn = false
                    } else {
                        self?.remoteRequestHandler?.remoteCallBackData(userpost: posts, totalPages: totalPages)
                    }
                }
            case .failure(let error): print("Error processing  home posts\(error)")
            }
        }
    }
}
