//
//  PostInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//  
//

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
    
    func interactorCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?) {
        self.remoteDatamanager?.remoteCheckIfLikesExist(postId: postId, userId: userId, token: token, post: post)
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

extension PostInteractor: PostRemoteDataManagerOutputProtocol {
    func remoteCallBackDeleteLike(with message: ResMessage) {
        
    }
    
    // TODO: Implement use case methods
    func remoteCallBackLikesExist(with heart: [Heart], post: PostViewData?) {
        self.presenter?.interactorCallBackLikesExist(with: heart, post: post)
    }
}
