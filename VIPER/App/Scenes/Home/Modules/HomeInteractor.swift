//
//  HomeInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//
//
import Foundation
// MARK: HOME INTERACTOR
class HomeInteractor: HomeInteractorInputProtocol {
 
    // MARK:  PROPERTIES
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    /*
     - ------------ LLAMAR AL EXTERNALDATAMANEGER -------------
     - DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER)
     - QUE TIENE QUE TRAER UNOS DATOS.
     */
    func interactorGetData(token: String) {
        remoteDatamanager?.remoteGetData( token: token )
    }
    
    func interactorCreateLike(post: Post?, userId: Int, token: String) {
        self.remoteDatamanager?.remoteCreateLike(post: post, userId: userId, token: token)
    }
    
    func interactorDeleteLike(heart: Heart?, token: String) {
       self.remoteDatamanager?.remoteDeleteLike(heart: heart, token: token)
    }
    
    func interactorCheckIfLikesExist(postId: Int, userId: Int, token: String, post: Post?) {
        self.remoteDatamanager?.remoteCheckIfLikesExist(postId: postId, userId: userId, token: token, post: post)
    }
}


// MARK: - OUTPUT REMOTE MANAGER PROTOCOL
extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    /*
     - ------------ LLAMAR AL PRESENTER -------------
     - EL INTERACTOR DEBE ENVIARLE LOS DATOS AL
     - PRESENTER BIEN "MASTICADITO"
     */
    func remoteCallBackData( with homeFeedRenderViewModel: [ HomeFeedRenderViewModel ] ) {
        presenter?.interactorCallBackData( with: homeFeedRenderViewModel )
    }
    
    func interactorCreateLike(like: Heart?) {
        
    }
    
    func remoteCallBackLikesExist(with heart: [Heart],  post: Post?) {
        self.presenter?.interactorCallBackLikesExist(with: heart, post: post)
    }
    
    func remoteCallBackInsertLike(with heart: Heart) {
        
    }
    
    func remoteCallBackDeleteLike(with message: ResMessage) {
        self.presenter?.interactorCallBackDeleteLike(with: message)
    }

}

