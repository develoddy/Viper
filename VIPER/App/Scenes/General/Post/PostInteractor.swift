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
    func interactorGetData(userpost: Userpost) {
        guard let comments = userpost.comments else {
            return
        }
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .descriptions(post: userpost)))
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
        renderModels.append(PostRenderViewModel(renderType: .footer(footer: userpost)))
        
        self.presenter?.interactorCallBackData(userPost: renderModels)
    }

}

extension PostInteractor: PostRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
