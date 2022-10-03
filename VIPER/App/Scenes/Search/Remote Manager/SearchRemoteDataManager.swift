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
    
    
    // MARK: - FUNCTIONS
    
    // LLAMAR AL API REST PARA TRAER TODAS LAS PUBLICACIONES.
    func remoteGetData(page: Int, isPagination:Bool, token: String) {
        
        if isPagination {
            isPaginationOn = true
        }
        
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/\(page)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResPosts.self, from: data )
                    guard let post = tasks.resPostImages?.posts, let totalPages = tasks.resPostImages?.totalPages else {
                        return
                    }
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    if isPagination {
                        self.remoteRequestHandler?.remoteCallBackDataAppend(userpost: post)
                        if isPagination {
                            self.isPaginationOn = false
                        }
                    } else {
                        self.remoteRequestHandler?.remoteCallBackData(userpost: post, totalPages: totalPages)
                        if isPagination {
                            self.isPaginationOn = false
                        }
                    }
                } catch {
                    print(" SearchRemoteDataManager: Error catch... ")
                }
            }
        }
        task.resume()
    }
    
}
