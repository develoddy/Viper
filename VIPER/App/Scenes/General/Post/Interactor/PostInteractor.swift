import Foundation

class PostInteractor: PostInteractorInputProtocol {
    
    // MARK: PROPERTIES
    weak var presenter: PostInteractorOutputProtocol?
    var localDatamanager: PostLocalDataManagerInputProtocol?
    var remoteDatamanager: PostRemoteDataManagerInputProtocol?
    
    private var renderModels = [PostRenderViewModel]()
    
    // MARK: FUNCTION
    func interactorGetData(userpost: PostViewData) {
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .descriptions(post: userpost)))
        self.presenter?.interactorCallBackData(userPost: renderModels)
    }
    
    func interactorCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?, sender: HeartButton) {
        self.remoteDatamanager?.remoteCheckIfLikesExist(postId: postId, userId: userId, token: token, post: post, sender: sender)
    }
    
    func interactorCreateLike(post: PostViewData?, userId: Int, token: String) {
        self.remoteDatamanager?.remoteCreateLike(post: post, userId: userId, token: token)
    }
    
    func interactorDeleteLike(heart: Heart?, token: String) {
        self.remoteDatamanager?.remoteDeleteLike(heart: heart, token: token)
    }
    
    func interactorDeletePost(post: PostViewData?, token: String) {
        self.remoteDatamanager?.remoteDeletePost(post: post, token: token)
    }
}


// MARK: - OUT PUT
extension PostInteractor: PostRemoteDataManagerOutputProtocol {
    func remoteLikeFailed() {
        // CODE
    }
    
    func remoteCallBackDeleteLike(with message: ResMessage) {
        // CODE
    }
    
    /* TODO: SE APLICA LA LOGICA SI EXISTE O NO "EL ME GUSTA"
     * EL INTERACTOR RECIBE LOS DATOS QUE VIENE DEL REMOTE MANAAGER
     * SE COMPRUEBA SI EXISTE O NO "EL ME GUSTA" PARA ENVIASELO AL PRESENTER. */
    func remoteCallBackLikesExist(with heart: [Heart], post: PostViewData?, sender: HeartButton) {
        DispatchQueue.main.async {[weak self] in
            if heart.count != 0 {
                // SI EXISTE LIKE.
                for item in heart {
                    self?.presenter?.interactorCallBackLikesExist(with: item, sender: sender)
                }
            } else {
               // NO EXISTE LIKE.
                self?.presenter?.interactorCallBackLikeNotExist(post: post, sender: sender)
            }
        }
    }
}
