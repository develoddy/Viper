//
//  PostPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//  
//

import Foundation

class PostPresenter: PostPresenterProtocol  {
    
    // MARK: PROPERTIES
    weak var view: PostViewProtocol?
    var interactor: PostInteractorInputProtocol?
    var wireFrame: PostWireFrameProtocol?
    var userpostReceivedFromProfile: Userpost?
    
    private var renderModels = [PostRenderViewModel]()
    
    // MARK: FUNCTION
    func viewDidLoad() {
        
        // SE RECIBE EL OBJECTO POST QUE VIENE DEL MODULO PROFILE
        guard let userPost = userpostReceivedFromProfile else {
            return
        }
        // SE LLAMA AL INTERACTOR
        self.interactor?.interactorGetData(userpost: userPost)
    }
    
    func presenterNumberOfSections() -> Int {
        return self.renderModels.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        switch renderModels[section].renderType {
            case .actions(_):  return 1
            case .comments(_): return 1
            case .primaryContent(_):  return 1
            case .header(_):  return 1
            case .descriptions(_):  return 1
            case .footer(_): return 1
        }
    }
    
    func cellForRowAt(at index: IndexPath) -> PostRenderViewModel {
        return renderModels[index.section]
    }
    
}



// MARK: - OUTPUT
extension PostPresenter: PostInteractorOutputProtocol {
    
    // SE RECIBE LOS DATOS QUE LLEGA DEL INTERACTOR
    func interactorCallBackData(userPost: [PostRenderViewModel]) {
        self.renderModels = userPost
    }
}
