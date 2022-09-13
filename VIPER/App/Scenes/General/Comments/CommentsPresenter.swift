import Foundation

enum UserPostViewModelRenderType {
    case comments(comments: [Comment])
}

struct UserPostViewModelRenderViewModel {
    let renderType: UserPostViewModelRenderType
}


class CommentsPresenter : CommentsPresenterProtocol {
    
    // MARK: PROPERTIES.
    weak var view: CommentsViewProtocol?
    var interactor: CommentsInteractorInputProtocol?
    var wireFrame: CommentsWireFrameProtocol?
    var userpostReceivedFromHome: Post?
    private var commentPost: CommentPost?
    private var token = Token()
    
    // MARK: CLOSURES
    var renderModels: [Comment] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    func viewDidLoad() {
        guard let idPost = self.userpostReceivedFromHome?.id, let token = token.getUserToken().success else {
            return
        }
        
        
        // LLAMAR AL INTERACTOR.
        self.interactor?.interactorReadByComment(idPost: idPost, pagination: 0, token: token)
        self.view?.startActivity()
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return 1
       
    }
    
    // GET NUMBER OF ROWS INSECTION.
    func numberOfRowsInsection(section: Int) -> Int {
        return self.renderModels.count > 0 ? self.renderModels.count : self.renderModels.count
    }
    
    // GET DATA COMMENTS.
    func showCommentsData(indexPath: IndexPath) -> Comment {
        return self.renderModels[indexPath.row]
    }
    
    // SHOW DATA HEADER.
    func showHeaderCommentData() -> Post {
        guard let userPostViewModelModel = self.userpostReceivedFromHome else {
            fatalError("Error showCommentsData")
        }
        return userPostViewModelModel
    }
    
    // CREATE COMENTARIO
    func insertComment( textComment: String ) {
        
        guard let identity = token.getUserToken().user?.id else {
            return
        }
        self.commentPost = CommentPost(
            typeID: 0,
            refID: 0,
            user_id: 0,
            content: textComment,
            commentID: 0,
            createdAt: "2021-12-26 20:47:23",
            updatedAt: "2021-12-26 20:47:23",
            postID: userpostReceivedFromHome?.id ?? 0,
            userID: identity )
        
        guard let token = token.getUserToken().success else {
            return
        }
        
        // LLAMAR AL INTERACTOR
        self.interactor?.interactorSetComment(pagination: false, commentPost: self.commentPost, token: token)
    }
    
    // UPDATE COMENTARIO.
    func updateComment(indexPath: IndexPath, content: String) {
        guard let postId = self.renderModels[indexPath.row].postId,
              let idComment = self.renderModels[indexPath.row].id,
              let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorUpdateComment(idPost: postId, idComment: idComment, content: content, token: token)
        self.renderModels[indexPath.row].content = content
    }
    
    // BORRAR COMENTARIO.
    func deleteRow(indexPath: IndexPath) {
        guard let id = self.renderModels[indexPath.row].id,
              let token = token.getUserToken().success else {
            return
        }

        self.interactor?.interactorDeleteComment(id: id, token: token)
        self.renderModels.remove(at: indexPath.row)
    }
    
    // FETCH MORE DATA.
    func fetchMoreData() {
    }
}



// MARK: - OUT PUT
extension CommentsPresenter: CommentsInteractorOutputProtocol {
  
    func interactorCallBackListComments(with comments: [Comment]) {
        // OBTENDREMOS LA LISTA DE COMENTARIOS QUE LA BASE DE DATOS
        // NOS HA DEVUELTO.
        self.renderModels = comments
        self.view?.stopActivity()
    }
    
   
    // TODO: implement interactor output methods
    func interactorCallBackData(with comment: [Comment]) {
        // OBTENDREMOS LA LISTA DE COMENTARIOS QUE LA BASE DE DATOS
        // NOS HA DEVUELTO.
        
        //print("PResenter BACK: ")
        //print(comment)
        self.renderModels = []
        self.renderModels = comment
        self.view?.stopActivity()
    }
    
    // DELETE COMMENT
    func interactorCallBackDeleteComment(with delete: Bool) {
        // SI EL BORRADO EN LA BASE DE DATOS FUE EXITOSO
        // ENTONCES OBTENDRMOS UN VALOR BOOLEANO "TRUE" O "FALSE".
        if !delete {
            print("Hubo un error al borrar el comentario...")
        }
    }
    
    func interactorCallBackUpdateComment(with update: [Int]) {
        // SI LA MODIFICACION EN LA BASE DE DATOS FUE EXITOSO
        // ENTONCES OBTENDREMOS COMO RESULTADO UN ARRAY CON UN NUMERICO 1.
    }
}
