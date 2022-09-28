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
        self.apiManager.fetchPosts(page: page, isPagination: isPagination, token: token) { [weak self] response in
            if let posts = response?.resPostImages?.posts, let totalPages = response?.resPostImages?.totalPages {
                self?.remoteRequestHandler?.remoteCallBackData(with: posts, totalPages: totalPages)
                if isPagination {
                    self?.isPaginationOn = false
                }
            } else {
                // POSIBLE ERROR.
            }
        }
    }
    
    /* -------------------------------------------
     * TODO: CREAR ME GUSTA.
     * SE LLAMA AL API MANAGER PARA CREAR O INSERTAR "ME GUSTA". */
    func remoteCreateLike(post: PostViewData?, userId: Int, token: String) {
        
        self.apiManager.insertLike(post: post, userId: userId, token: token) { [weak self] response in
            if let _ = response {
                // LLAMAR AL INTERACTOR
            } else {
                // ERROR.
                self?.remoteRequestHandler?.remoteLikeFailed()
            }
        }
    }
    
    /* -------------------------------------------
     * TODO: ELIMINAR ME GUSTA
     * SE LLAMA AL API MANAGER PARA INTENTAR ELIMINAR "EL ME GUSTA". */
    func remoteDeleteLike(heart: Heart?, token: String) {
        self.apiManager.homeDeleteLike(heart: heart, token: token) { [weak self] response in
            if let task = response {
                self?.remoteRequestHandler?.remoteCallBackDeleteLike(with: task)
            } else {
                // ERROR
            }
        }
    }
    
    /* -------------------------------------------
     * TODO: COMPROBAR SI EXISTE "ME GUSTA"
     * SE LLAMA AL API REST PARA QUE NOS DIGA SI EXISTE "EL MESGUSTA" O NO. */
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?) {
        self.apiManager.homeCheckIfLikesExist(postId: postId, userId: userId, token: token) { [weak self] response in
            if let heart = response {
                self?.remoteRequestHandler?.remoteCallBackLikesExist(with: heart, post: post)
            } else {
                // ERROR
            }
        }
    }
}
