import Foundation

class PostRemoteDataManager:PostRemoteDataManagerInputProtocol {
    
    // MARK: PROPERTIES
    var remoteRequestHandler: PostRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    /* TODO: COMPROBACION SI EXISTE O NO "EL ME GUSTA"
     * SE LLAMA AL API MANAGER PARA QUE NOS DIGA SI "EL ME GUSTA" ESTÁ CREADO O NO,
     * PARA HACERLO SABER AL INTERACTOR COMO RESPUESTA DE VUELTA. */
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?, sender: HeartButton) {
        /*self.apiManager.checkIfLikesExist(postId: postId, userId: userId, token: token) { [weak self] response in
            if let heart = response {
                self?.remoteRequestHandler?.remoteCallBackLikesExist(with: heart, post: post, sender: sender)
            } else {
                // ERROR
            }
        }*/
        
        // LLAMAR AL API MANAGER
        self.apiManager.checkIfLikesExist(postId: postId, userId: userId, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let heart = response {
                    self?.remoteRequestHandler?.remoteCallBackLikesExist(with: heart, post: post, sender: sender)
                }
            case .failure(let error): print("Error processing  home create like\(error)")
            }
        }
    }
    
    /* TODO: SE CREA "EL ME GUSTA"
     * SE LLAMA AL API MANAGER PARA CREAR "EL ME GUSTA". */
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
    
    /* TODO: SE BORRA "EL ME GUSTA"
     * SE LLAMA AL API MANAGER PARA BORRAR "EL ME GUSTA". */
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
    
    
    // DELETE POST.
    func remoteDeletePost(post: PostViewData?, token: String) {
        print("Post REMOTE")
    }
    
}
