import Foundation

// MARK: HOME INTERACTOR
class HomeInteractor: HomeInteractorInputProtocol {
 
    // MARK:  PROPERTIES
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    var models: [HomeFeedRenderViewModel] = []
    
    /* TODO: LLAMAR AL REMOTE MANAGER
     * DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER)
     * QUE TIENE QUE TRAER UNOS DATOS. */
    func interactorGetData(page: Int, isPagination:Bool, token: String) {
        remoteDatamanager?.remoteGetData(page: page, isPagination: isPagination, token: token)
    }
    
    func interactorCreateLike(post: PostViewData?, userId: Int, token: String) {
        self.remoteDatamanager?.remoteCreateLike(post: post, userId: userId, token: token)
    }
    
    func interactorDeleteLike(heart: Heart?, token: String) {
       self.remoteDatamanager?.remoteDeleteLike(heart: heart, token: token)
    }
    
    func interactorCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?) {
        self.remoteDatamanager?.remoteCheckIfLikesExist(postId: postId, userId: userId, token: token, post: post)
    }
}


// MARK: - OUTPUT REMOTE MANAGER PROTOCOL
extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
   
    /* TODO: LLAMAR AL PRESENTER
     * EL INTERACTOR DEBE ENVIARLE LOS DATOS AL
     * PRESENTER BIEN "MASTICADITO". */
    func remoteCallBackData(with posts: [Post], totalPages: Int) {
       
        DispatchQueue.main.async {[weak self] in
            let formattedItemsPost = posts.map{PostViewData(info: $0)}
            for items in formattedItemsPost {
                //print(items.content)
                let formattedItemsComment = items.comments.map{CommentViewData(info: $0)}
                let viewModel = HomeFeedRenderViewModel(
                    header: PostRenderViewModel(renderType: .header( provider: items )),
                    post: PostRenderViewModel(renderType: .primaryContent( provider: items )),
                    actions: PostRenderViewModel(renderType: .actions( provider: items )),
                    descriptions: PostRenderViewModel(renderType: .descriptions( post: items )),
                    comments: PostRenderViewModel(renderType: .comments( comments: formattedItemsComment )) )
                self?.models.append( viewModel )
            }
            // LLAMAR AL PRESENTER.
            self?.presenter?.interactorCallBackData( with: self?.models ?? [], totalPages: totalPages )
        }
    }
    
    
    func remoteRefreshCallBackData(with posts: [Post]) {
        DispatchQueue.main.async {[weak self] in
            let formattedItemsPost = posts.map{PostViewData(info: $0)}
            for items in formattedItemsPost {
                let formattedItemsComment = items.comments.map{CommentViewData(info: $0)}
                let viewModel = HomeFeedRenderViewModel(
                    header: PostRenderViewModel(renderType: .header( provider: items )),
                    post: PostRenderViewModel(renderType: .primaryContent( provider: items )),
                    actions: PostRenderViewModel(renderType: .actions( provider: items )),
                    descriptions: PostRenderViewModel(renderType: .descriptions( post: items )),
                    comments: PostRenderViewModel(renderType: .comments( comments: formattedItemsComment )) )
                self?.models.append( viewModel )
                
            }
            // LLAMAR AL PRESENTER.
            //self?.presenter?.interactorCallBackData( with: self?.models ?? [], totalPages: totalPages )
            self?.presenter?.interactorRefreshCallBackData(with: self?.models ?? [] )
        }
    }
    
    func interactorCreateLike(like: Heart?) {
        
    }
    
    func remoteCallBackLikesExist(with heart: [Heart],  post: PostViewData?) {
        self.presenter?.interactorCallBackLikesExist(with: heart, post: post)
    }
    
    func remoteCallBackInsertLike(with heart: Heart) {
        
    }
    
    func remoteCallBackDeleteLike(with message: ResMessage) {
        self.presenter?.interactorCallBackDeleteLike(with: message)
    }
    
    func remoteLikeFailed() {
        self.presenter?.interactorLikeFailed()
    }

}

