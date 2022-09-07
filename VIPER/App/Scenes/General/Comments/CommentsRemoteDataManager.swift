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
    
    // INSERTAR COMENTARIOS.
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
                    self.remoteRequestHandler?.remoteCallBackData(with: task)
                } catch {
                    print(error)
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
    }
    
}
