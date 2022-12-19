import UIKit
class PostPresenter: PostPresenterProtocol {
    
    // MARK: PROPERTIES
    weak var view: PostViewProtocol?
    var interactor: PostInteractorInputProtocol?
    var wireFrame: PostWireFrameProtocol?
    var userpostReceivedFromProfile: PostViewData?
    var indexPathReceivedFromProfile: IndexPath?
    var token = Token()
    
    //var renderModels: [PostRenderViewModel] = []
    // MARK: CLOUSURES
    var renderModels: [PostRenderViewModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }
   
 
    func viewDidLoad() {
        /* TODO: OBTENER LA PUBLICACION.
         * LLAMAR AL INTERACTOR.
         * LE DECIMOS AL INTERACTOR QUE QUEREMOS OBTENER LA PUBLICACION QUE
         * NOS HA ENVIADO OTRO MODULO (PROFILE O SEARCH). */
        guard let post = self.userpostReceivedFromProfile else { return }
        self.interactor?.interactorGetData(userpost: post)
    }
    
    /* TODO: CONTAR NUMERO DE SECCIONES.
     * SE DEVUELVE EL NUMERO DE SECCIONES A LA VISTA. */
    func presenterNumberOfSections() -> Int {
        return self.renderModels.count
    }
    
    /* TODO: CONTAR NUMERO DE FILAS DE SECCIONES.
     * SE DEVUELVE EL NUMERO DE FILAS DE SECCIONES A LA VISTA. */
    func numberOfRowsInsection(section: Int) -> Int {
        switch renderModels[ section ].renderType {
            case .actions(_): return 1
            case .comments(_): return 1
            case .primaryContent(_): return 1
            case .header(_): return 1
            case .descriptions(_): return 1
        }
    }
    
    /* TODO: DATOS PARA CADA CELDA
     * SE DEVUELVE LOS DATOS A LA VISTA. */
    func cellForRowAt(at index: IndexPath) -> PostRenderViewModel {
        return renderModels[index.section]
    }
    
    /* TODO: IDENTIDAD
     * OBTENEMOS LOS DATO DE INDENTIDAD DEL USUARIO QUE ESTÁ
     * LOGUEADO ACTUALMENTE. */
    func getIdentity() -> UserLogin? {
        guard let identity = self.token.getUserToken().user else {
            fatalError("error show data user token")
        }
        return identity
    }
    
    /* TODO: INDICE DE LA PUBLICACION
     * SE DEVUELVE A LA VISTA EL INDICE DE LA PUBLICACION. */
    func getIndexPathReceivedFromProfile() -> IndexPath {
        guard let indexPath = self.indexPathReceivedFromProfile else {
            return IndexPath()
        }
        return indexPath
    }
    
    /* TODO: NAVEGAR A OTRO MODULO "COMMENTS"
     * LLAMAR AL WIREFRAME.
     * QUEREMOS NAVEGAR A OTRO MODULO "COMMENTS". */
    func gotoCommentsScreen(post: PostViewData) {
        self.wireFrame?.navigateToComments(from: view!, post: post)
    }
    
    /* TODO: COMPROBAR SI EXISTE "ME GUSTA"
     * LLAMAR AL INTERACTOR.
     * LE DECIMOS AL INTERACTOR SI EL "ME GUSTA" EXISTE O NO. */
    func checkIfLikesExist(post: PostViewData?, sender: HeartButton) {
        guard let postId = self.userpostReceivedFromProfile?.id,
              let userId = token.getUserToken().user?.id,
              let token = token.getUserToken().success,
              let post = self.userpostReceivedFromProfile else {
            return
        }
        self.interactor?.interactorCheckIfLikesExist(postId: postId, userId: userId, token: token, post: post, sender: sender)
    }
    
    /* TODO: CREAR "ME GUSTA"
     * LLAMAR AL INTERACTOR.
     * LE DECIMOS AL INTERACTOR QUE QUEREMOS CREAR UN "ME GUSTA". */
    func createLike(post: PostViewData?) {
        guard let identityId = token.getUserToken().user?.id,
              let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorCreateLike(post: post, userId:identityId, token: token)
    }
    
    /* TODO: BORRAR "ME GUSTA"
     * LLAMAR AL INTERACTOR.
     * LE DECIMOS AL INTERACTOR QUE QUEREMOS BORRAR UN "ME GUSTA". */
    func deleteLike(heart: Heart?) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorDeleteLike(heart: heart, token: token)
    }
    
    /* TODO: NAVEGAR A OTRO MODULO "SHEE POST"
     * LLAMAR AL WIREFRAME.
     * QUEREMOS NAVEGAR A OTRO MODULO "SHEE POST". */
    func gotoSheePostView(post: PostViewData) {
        self.wireFrame?.navigateSheePostView(from: view!, post: post, indexPath: self.getIndexPathReceivedFromProfile())
    }
    
    /* TODO: BORRAR PUBLICACIÓN
     * LLAMAR AL INTERACTOR.
     * LE DECIMOS AL INTERACTOR QUE QUEREMOS BORRAR LA PUBLICACIÓN. */
    func deletePost(post: PostViewData?) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorDeletePost(post: post, token: token)
    }
}



// MARK: - OUTPUT
extension PostPresenter: PostInteractorOutputProtocol {
    /* TODO: SE OBTIENE LA PUBLICACION
     * EL PRESENTER RECIBE EL ARRAY DE PUBLICACION. */
    func interactorCallBackData(userPost: [PostRenderViewModel]) {
        self.renderModels = userPost
    }
    
    /* TODO: SI EXISTE "EL ME GIUSTA"
     * EL PRESENTER RECIBE LOS DATOS DE VERIFICACION "EL ME GUSTA" PARA SABER
     * ENVIARSELO A LA VISTA. */
    func interactorCallBackLikesExist(with heart: Heart?, sender: HeartButton) {
        DispatchQueue.main.async {[weak self] in
            guard let like = heart else { return }
            self?.view?.likeExist(heart: like, sender: sender)
        }
    }
    /* TODO: SI NO EXISTE "EL ME GIUSTA"
     * EL PRESENTER RECIBE LOS DATOS DE VERIFICACION "EL ME GUSTA" PARA SABER
     * ENVIARSELO A LA VISTA. */
    func interactorCallBackLikeNotExist(post: PostViewData?, sender: HeartButton) {
        DispatchQueue.main.async {[weak self] in
            guard let postData = post else { return }
            self?.view?.likeNotExist(post: postData, sender: sender)
        }
    }
    
    func interactorCallBackInsertLike(with heart: Heart) {
        // CODE
    }
    
    func interactorCallBackDeleteLike(with message: ResMessage) {
        // CODE
    }
    
    func interactorLikeFailed() {
        // CODE
    }
}
