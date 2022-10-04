import Foundation
class CommentsRemoteDataManager:CommentsRemoteDataManagerInputProtocol {
    
    // MARK: PORPERTIES
    var remoteRequestHandler: CommentsRemoteDataManagerOutputProtocol?
    var isPagination: Bool = false
    let apiManager: ProAPIManagerProtocol
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    
    // READ COMMENTS BY ID POST
    func remoteReadByComment(idPost: Int, pagination: Int, token: String) {
        self.apiManager.fetchReadByComment(postId: idPost, pagination: pagination, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let comments = response {
                    self?.remoteRequestHandler?.remoteCallBackListComments(with: comments)
                }
            case .failure(let error): print("Error processing comment read\(error)")
            }
        }
    }
    
    // INSERT COMMENT
    func remoteSetComment(pagination: Bool, commentPost: CommentPost?, token: String) {
        self.apiManager.insertComment(pagination: pagination, commentPost: commentPost, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let comment = response {
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self?.remoteRequestHandler?.remoteCallBackData(with: comment)
                }
            case .failure(let error): print("Error processing comment create\(error)")
            }
        }
    }
    
    
    
    // DELETE COMMENT
    func remoteDeleteComment(id: Int, token: String) {
        self.apiManager.deleteComment(id: id, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let delete = response?.message {
                    self?.remoteRequestHandler?.remoteCallBackDeleteComment(with: delete)
                }
            case .failure(let error):
                print("Error processing comment create\(error)")
            }
        }
    }
    
    
    // UPDATE COMMENT
    func remoteUpdateComment(idPost: Int, idComment: Int, content: String, token: String) {
        let param : [ String : Any ] = [
            "idComment": idComment,
            "postId": idPost,
            "content": content
        ]
    
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/comments/update" ) else {
            return
        }
        
        var request = URLRequest( url: url )
        if !content.isEmpty {
            do {
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: param,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpMethod = Constants.Method.httpPut
            } catch {}
        }
        
       
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let task = try decoder.decode( [Int].self, from: data )
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR.
                    self.remoteRequestHandler?.remoteCallBackUpdateComment(with: task)
                } catch {
                    print(error)
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
        
        
        self.apiManager.updateComment(postId: idPost, commentId: idComment, content: content, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response {
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR.
                    self?.remoteRequestHandler?.remoteCallBackUpdateComment(with: data)
                }
            case .failure(let error):
                print("Error processing comment create\(error)")
            }
        }
    }
}
