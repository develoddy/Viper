//
//  CommentsPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

enum UserPostViewModelRenderType {
    case primaryContent(posts: Post)
}

struct UserPostViewModelRenderViewModel {
    let renderType: UserPostViewModelRenderType
}

class CommentsPresenter : CommentsPresenterProtocol {
    
    // MARK: Properties
    weak var view: CommentsViewProtocol?
    var interactor: CommentsInteractorInputProtocol?
    var wireFrame: CommentsWireFrameProtocol?
    var userpostReceivedFromHome: Post?
    private var renderModels = [UserPostViewModelRenderViewModel]()
    
    // MEDIANTE EL WIREFRAME RECIBIMOS LOS DATOS QUE NOS ENVIA EL MODULO HOME (ACTION - COMMENTS)
    func viewDidLoad() {
        guard let userPostViewModelModel = self.userpostReceivedFromHome else { return }
        renderModels.append(UserPostViewModelRenderViewModel(renderType: .primaryContent(posts: userPostViewModelModel)))
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return renderModels.count
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        switch renderModels[section].renderType {
        case .primaryContent(let posts):
            guard let comments = posts.comments else { return 0 }
            return comments.count > 0 ? comments.count : comments.count
        }
    }
    
    // GET DATA
    func showCommentsData(indexPath: IndexPath) -> Comment {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .primaryContent(let posts):
            guard let comments = posts.comments else { fatalError("Error showCommentsData") }
            let comment = comments[indexPath.row]
            return comment
        }
    }
    
    func showHeaderCommentData(section: Int) -> Post {
        let model = renderModels[section]
        switch model.renderType {
        case .primaryContent(let post):
            return post
        }
    }
    
}



extension CommentsPresenter: CommentsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
