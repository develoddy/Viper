import Foundation

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {

    // MARK:  PROPIERTIES
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    var isPaginationOn: Bool? = false
    let apiManager: ProAPIManagerProtocol
    var models: [HomeFeedRenderViewModel] = []
  
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    /* -------------------------------------------
     * TODO: OBTENER LAS PUBLICACIONES
     * SE LLAMA AL API MANAGER PARA OBTENER TODAS LAS PUBLICACIONES. */
    func remoteGetData(page: Int, isPagination:Bool, token: String) {
        if isPagination {
            isPaginationOn = true
        }
        self.apiManager.fetchPosts(page: page, isPagination: isPagination, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let posts = response?.resPostImages?.posts, let totalPages = response?.resPostImages?.totalPages {
                    self?.remoteRequestHandler?.remoteCallBackData(with: posts, totalPages: totalPages)
                    if isPagination {
                        self?.isPaginationOn = false
                    }
                }
            case .failure(let error): print("Error processing  home posts\(error)")
            }
        }
    }
    
    func remoteRefreshPost(page: Int, isPagination:Bool, token: String) {
        self.apiManager.fetchPosts(page: page, isPagination: isPagination, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let posts = response?.resPostImages?.posts {
                    self?.remoteRequestHandler?.remoteRefreshCallBackData(with: posts)
                }
            case .failure(let error): print("Error processing  home posts\(error)")
            }
        }
    }
    
    /* -------------------------------------------
     * TODO: CREAR ME GUSTA.
     * SE LLAMA AL API MANAGER PARA CREAR O INSERTAR "ME GUSTA". */
    func remoteCreateLike(post: PostViewData?, userId: Int, token: String) {
        self.apiManager.insertLike(post: post, userId: userId, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let _ = response {
                    // LLAMAR AL INTERACTOR.
                } else {
                    self?.remoteRequestHandler?.remoteLikeFailed()
                }
            case .failure(let error): print("Error processing  home create like\(error)")
            }
        }
    }
    
    /* -------------------------------------------
     * TODO: ELIMINAR ME GUSTA
     * SE LLAMA AL API MANAGER PARA INTENTAR ELIMINAR "EL ME GUSTA". */
    func remoteDeleteLike(heart: Heart?, token: String) {
        self.apiManager.deleteLike(heart: heart, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let task = response {
                    self?.remoteRequestHandler?.remoteCallBackDeleteLike(with: task)
                }
            case .failure(let error): print("Error processing  home delete like\(error)")
            }
        }
    }
    
    /* -------------------------------------------
     * TODO: COMPROBAR SI EXISTE "ME GUSTA"
     * SE LLAMA AL API REST PARA QUE NOS DIGA SI EXISTE "EL MESGUSTA" O NO. */
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?) {
        self.apiManager.checkIfLikesExist(postId: postId, userId: userId, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let heart = response {
                    self?.remoteRequestHandler?.remoteCallBackLikesExist(with: heart, post: post)
                }
            case .failure(let error): print("Error processing  home create like\(error)")
            }
        }
    }
}
