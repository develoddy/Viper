//
//  CommentsRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class CommentsRemoteDataManager:CommentsRemoteDataManagerInputProtocol {
    
    // MARK: PORPERTIES
    var remoteRequestHandler: CommentsRemoteDataManagerOutputProtocol?
    var isPagination: Bool = false
    
    
    // READ COMMENTS BY ID POST
    func remoteReadByComment(idPost: Int, pagination: Int, token: String) {
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/comments/read/\(idPost)/\(pagination)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( [Comment].self, from: data )
                    self.remoteRequestHandler?.remoteCallBackListComments(with: tasks)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    // INSERT COMMENT
    func remoteSetComment(pagination: Bool, commentPost: CommentPost?, token: String) {
        guard let comment = commentPost else {
            return
        }
        let param : [ String : Any ] = [
            "type_id"   : comment.typeID!   ,
            "ref_id"    : comment.refID!    ,
            "user_id"   : comment.user_id!  ,
            "content"   : comment.content!  ,
            "comment_id": comment.commentID!,
            "created_at": comment.createdAt!,
            "updated_at": comment.updatedAt!,
            "postId"    : comment.postID!   ,
            "userId"    : comment.userID!   ,
        ]
    
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/comments/create" ) else {
            return
        }
        
        var request = URLRequest( url: url )
        if commentPost != nil {
            do {
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: param,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpMethod = Constants.Method.httpPost
            } catch {}
        }
        
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let task = try decoder.decode( [Comment].self, from: data )
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    print("Comment Remeote")
                    print(task)
                    self.remoteRequestHandler?.remoteCallBackData(with: task)
                } catch {
                    print(error)
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
    }
    
    
    
    // DELETE COMMENT
    func remoteDeleteComment(id: Int, token: String) {
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/comments/delete/\(id)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpDelete
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResMessage.self, from: data )
                    guard let delete = tasks.message else {
                        return
                    }
                    if delete {
                        // LLAMAR AL INTERACTOR
                        self.remoteRequestHandler?.remoteCallBackDeleteComment(with: delete)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
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
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackUpdateComment(with: task)
                } catch {
                    print(error)
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
    }
}
