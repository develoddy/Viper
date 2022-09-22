//
//  PostPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//
//
import Foundation
import UIKit
class PostPresenter: PostPresenterProtocol {
   
    
   
    // MARK: PROPERTIES
    weak var view: PostViewProtocol?
    var interactor: PostInteractorInputProtocol?
    var wireFrame: PostWireFrameProtocol?
    var userpostReceivedFromProfile: Post?
    var indexPathReceivedFromProfile: IndexPath?
    var token = Token()
    
    var renderModels: [PostRenderViewModel] = []
    // MARK: CLOUSURES
    /*var renderModels: [PostRenderViewModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }*/
   
    
    // MARK: FUNCTION
    func viewDidLoad() {
        // SE RECIBE EL OBJECTO POST QUE VIENE DEL MODULO PROFILEVIEW O SEARCHVIEW
        guard let post = userpostReceivedFromProfile else {
            return
        }
        // SE LLAMA AL INTERACTOR
        self.interactor?.interactorGetData(userpost: post)
    }

    func presenterNumberOfSections() -> Int {
        return self.renderModels.count
    }

    func numberOfRowsInsection(section: Int) -> Int {
        switch renderModels[ section ].renderType {
            case .actions(_): return 1
            case .comments(_): return 1
            case .primaryContent(_): return 1
            case .header(_): return 1
            case .descriptions(_): return 1
            //case .footer(_): return 1
        }
    }

    func cellForRowAt(at index: IndexPath) -> PostRenderViewModel {
        return renderModels[index.section]
    }
    
    func getIdentity() -> UserLogin? {
        guard let identity = self.token.getUserToken().user else {
            fatalError("error show data user token")
        }
        return identity
    }
    
    func getIndexPathReceivedFromProfile() -> IndexPath {
        guard let indexPath = self.indexPathReceivedFromProfile else {
            return IndexPath()
        }
        return indexPath
    }
    
    /* ---- LLAMAR AL WIREFRAME ----
     * PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (COMMENTS)
     */
    func gotoCommentsScreen(post: Post) {
        self.wireFrame?.navigateToComments(from: view!, post: post)
    }
    
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
    
    func createLike(post: Post?) {
        guard let identityId = token.getUserToken().user?.id,
              let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorCreateLike(post: post,
                                              userId:identityId,
                                              token: token)
    }
    
    func deleteLike(heart: Heart?) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorDeleteLike(heart: heart,
                                              token: token)
    }
    
    func gotoSheePostView(post: Post) {
        self.wireFrame?.navigateSheePostView(from: view!, post: post, indexPath: self.getIndexPathReceivedFromProfile())
    }
    
    // LLAMAR AL INTERACTOR
    // SE INTENTARÁ BORRAR LA PUBLICACIÓN DEL PERFIL.
    func deletePost(post: Post?) {
        guard let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorDeletePost(post: post, token: token)
    }
}



// MARK: - OUTPUT
extension PostPresenter: PostInteractorOutputProtocol {
    
    // SE RECIBE LOS DATOS QUE LLEGA DEL INTERACTOR
    func interactorCallBackData(userPost: [PostRenderViewModel]) {
        self.renderModels = userPost
    }
    
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
