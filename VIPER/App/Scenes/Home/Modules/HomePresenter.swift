//
//  HomePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

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
        /* --- LLAMAR AL INTERACTOR ---
         * DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
         */
        guard let token = token.getUserToken().success else { return }
        self.interactor?.interactorGetData(page: 0, isPagination: false, token: token)
        view?.startActivity()
    }
    
    func presenterNumberOfSections() -> Int {
        self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        let count = section
        let boxes = 6
        let position = count % 6 == 0 ? count / 6 : ((count - (count % 6)) / 6)
        model = self.viewModel[ position ]
        let subSection = count % boxes
        switch subSection {
            case 1:  return 1 // HEADER
            case 2:  return 1 // POST
            case 3:  return 1 // ACTION
            case 4:  return 1 // DESCRIPTION
            case 5: let commentsModel = model.comments
                switch commentsModel.renderType {
                    case .comments( comments: let comments ):
                        return comments.count > 2 ? 2 : comments.count
                    case .header,
                         .descriptions,
                         .actions,
                         .primaryContent : return 0
                         //.footer: return 0
                }
            //case 6:  return 1 // FOOTER
            default:  return 0
        }
    }
    
    func cellForRowAt(at index: Int) -> HomeFeedRenderViewModel {
        return self.viewModel[index]
    }
    
    /* ---- IDENTITY ----
     * SE OBTIENE LOS DATOS DEL USUARIO LOGUEADO.
     */
    func getIdentity() -> UserLogin? {
        guard let identity = self.token.getUserToken().user else {
            fatalError("error show data user token")
        }
        return identity
    }

    /* ---- LLAMAR AL WIREFRAME ----
     * PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (PROFILE)
     */
    func gotoProfileScreen(id: Int, name: String, token: String) {
        self.wireFrame?.navigateToProfile(from: view!, id: id, name: name, token: token)
    }
    
    /* ---- LLAMAR AL WIREFRAME ----
     * PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (COMMENTS)
     */
    func gotoCommentsScreen(userpost: Post) {
        self.wireFrame?.navigateToComments(from: view!, userpost: userpost)
    }
    
    /* ---- VERIFICAR LIKE SI EXISTE EN DDBB ----
     * VERIFICAR SI EL LIKE EXISTE EN LA BASE DE DATOS.
     */
    func checkIfLikesExist(post: Post?) {
        guard let postId = post?.id,
              let userId = token.getUserToken().user?.id,
              let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorCheckIfLikesExist(postId: postId,
                                                     userId: userId,
                                                     token: token,
                                                     post: post)
    }
    
    /* ---- LLAMAR AL INTERACTOR ----
     * LE DECIMOS AL INTERACTOR QUE QUEREMOS CREAR UN LIKE.
     */
    func createLike(post: Post?) {
        guard let identityId = token.getUserToken().user?.id,
              let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorCreateLike(post: post,
                                              userId:identityId,
                                              token: token)
    }
    
    /* ---- LLAMAR AL INTERACTOR ----
     * LE DECIMOS AL INTERACTOR QUE QUEREMOS BORRAR UN LIKE.
     */
    func deleteLike(heart: Heart?) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorDeleteLike(heart: heart,
                                              token: token)
    }
    
    func getTotalPages() -> Int {
        return self.totalPages
    }
    
    func loadMoreData(page: Int) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorGetData(page: page, isPagination: true, token: token)
    }
}



// MARK: - OUTPUT HOME INTERACTOR PROTOCOL <
extension HomePresenter: HomeInteractorOutputProtocol {
    /* --- LLAMAR AL VIEW ---
     * EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE LE ENVIA EL INTERACTOR.
     */
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel], totalPages: Int) {
        self.viewModel = homeFeedRenderViewModel
        view?.stopActivity()
        self.totalPages = totalPages
    }
    
    /* --- LLAMAR AL VIEW ---
     * EL PRESENTER RECIBE LOS DATOS DE VERIFICACION EL LIKE
     * SI EXISTE O NO EN LA DDBB.
     */
    func interactorCallBackLikesExist(with heart: [Heart], post: Post?) {
        guard let model = post else {
            return
        }
        if heart.count != 0 {
            for item in heart {
                self.view?.stateHeart(heart: item,
                                      post: model)
            }
        } else {
            let item = Heart(id: nil,
                             typeID: nil,
                             refID: nil,
                             userID: nil,
                             createdAt: nil,
                             updatedAt: nil)
            self.view?.stateHeart(heart: item, post: model)
        }
    }
    
    func interactorCallBackInsertLike(with heart: Heart) {
        // -
    }
    
    func interactorCallBackDeleteLike(with message: ResMessage) {
        // -
    }
}
