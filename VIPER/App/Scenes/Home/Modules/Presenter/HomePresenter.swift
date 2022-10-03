import Foundation

// MARK: PRESENTER
class HomePresenter: HomePresenterProtocol  {
    
    // MARK:  PROPERTIES
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    var heart: [Heart]?
    var token = Token()
    var totalPages: Int!
    
    // MARK: CLOUSURES
    var viewModel: [HomeFeedRenderViewModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }
    
    func viewDidLoad() {
        /* TODO: LLAMAR AL INTERACTOR
         * EN ESTE PUNTO LE DECIMOS AL INTERACTOS QUE QUEREMOS OBTENER
         * TODAS LAS PUBLICACIONES. */
        guard let token = token.getUserToken().success else { return }
        self.interactor?.interactorGetData(page: 0, isPagination: false, token: token)
        view?.startActivity()
    }
    
    /* TODO: CONTAR NUMERO DE SECCIONES.
     * SE DEVUELVE EL NUMERO DE SECCIONES A LA VISTA. */
    func presenterNumberOfSections() -> Int {
        self.viewModel.count
    }
    
    /* TODO: CONTAR NUMERO DE FILAS DE SECCIONES.
     * SE DEVUELVE EL NUMERO DE FILAS DE SECCIONES A LA VISTA. */
    func numberOfRowsInsection(section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        let count = section
        let boxes = 6
        let position = count % 6 == 0 ? count / 6 : ((count - (count % 6)) / 6)
        model = self.viewModel[ position ]
        let subSection = count % boxes
        switch subSection {
            case 1: return 1 // HEADER
            case 2: return 1 // POST
            case 3: return 1 // ACTION
            case 4: return 1 // DESCRIPTION
            case 5: let commentsModel = model.comments
                switch commentsModel.renderType {
                    case .comments( comments: let comments ):
                        return comments.count > 2 ? 2 : comments.count
                    case .header, .descriptions, .actions, .primaryContent : return 0
                }
            default:  return 0
        }
    }
    
    /* TODO: DATOS PARA CADA CELDA
     * SE DEVUELVE LOS DATOS A LA VISTA. */
    func cellForRowAt(at index: Int) -> HomeFeedRenderViewModel {
        return self.viewModel[index]
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

    /* TODO: NAVEGAR A OTRO MODULO "PROFILE"
     * LLAMAR AL WIREFRAME.
     * QUEREMOS NAVEGAR A OTRO MODULO "PROFILE". */
    func gotoProfileScreen(id: Int, name: String, token: String) {
        self.wireFrame?.navigateToProfile(from: view!, id: id, name: name, token: token)
    }
    
    /* TODO: NAGEAR A OTRO MODULO "COMMENTS"
     * LLAMAR AL WIREFRAME.
     * QUEREMOS NAVEGAR A OTRO MODULO "COMMENTS". */
    func gotoCommentsScreen(userpost: PostViewData) {
        self.wireFrame?.navigateToComments(from: view!, userpost: userpost)
    }
    
    /* TODO: COMPROBAR SI EXISTE "ME GUSTA"
     * LLAMAR AL INTERACTOR.
     * LE DECIMOS AL INTERACTOR SI EL "ME GUSTA" EXISTE O NO. */
    func checkIfLikesExist(post: PostViewData?) {
        guard let postId = post?.id,
              let userId = token.getUserToken().user?.id,
              let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorCheckIfLikesExist(postId: postId, userId: userId, token: token, post: post)
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
    
    /* TODO: TOTAL PAGINAS DE LAS PUBLICACIONES
     * SE DEVUELVE A LA VISTA EL TOTAL DE PAGINAS QUE TIENE TODAS LAS PUBLICACIONES. */
    func getTotalPages() -> Int {
        return self.totalPages
    }
    
    /* TODO: VER MAS PUBLICACIONES O PAGINACIONES.
     * LLAMAR AL INTERACTOR.
     * LE DECIMOS AL INTERACTOR QUE QUEREMOS HACER MAS PAGINADO PARA VER MÁS
     * PUBLICACIONES EN LA VISTA. */
    func loadMoreData(page: Int) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorGetData(page: page, isPagination: true, token: token)
    }
    
    /* TODO: NAVEGAR A OTRO MODULO "SHE HOME"
     * LLAMAR AL WIREFRAME
     * LE DECIMOS AL WIREFRAME QUE QUEREMOS NACEGAR A OTRO MODULO "SHE HOME". */
    func gotoSheetHomePostsView(post: PostViewData) {
        self.wireFrame?.navigateSheetHomePostsView(from: view!, post: post)
    }
}



// MARK: - OUT PUT 
extension HomePresenter: HomeInteractorOutputProtocol {
   
    /* TODO: SE OBTIENE TODAS LAS PUBLICACIONES
     * EL PRESENTER RECIBE EL ARRAY DE OBJETOS DE TODAS
     * LAS PUBLICACIONES Y EL TOTAL DE PAGINAS. */
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel], totalPages: Int) {
        self.viewModel = homeFeedRenderViewModel
        view?.stopActivity()
        self.totalPages = totalPages
    }
    
    /* TODO: DE OBTIENE EL RESULTADO DE LA VERIFICACION DE "ME GUSTA"
     * EL PRESENTER RECIBE LOS DATOS DE VERIFICACION "EL GUSTA" PARA SABER
     * SI YA ESTABA CREADO O NO. */
    func interactorCallBackLikesExist(with heart: [Heart], post: PostViewData?) {
        guard let model = post else {
            return
        }
        if heart.count != 0 {
            for item in heart {
                self.view?.stateHeart(heart: item, post: model)
            }
        } else {
            let item = Heart(id: nil, typeID: nil, refID: nil, userID: nil, createdAt: nil, updatedAt: nil)
            self.view?.stateHeart(heart: item, post: model)
        }
    }
    
    func interactorCallBackInsertLike(with heart: Heart) {
        // - CODE
    }
    
    func interactorCallBackDeleteLike(with message: ResMessage) {
        // - CODE
    }

    func interactorLikeFailed() {
        // ERROR.
    }
}
