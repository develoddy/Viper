//
//  PostRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//  
//

import Foundation

class PostRemoteDataManager:PostRemoteDataManagerInputProtocol {
    
    
   
    // MARK: PROPERTIES
    var remoteRequestHandler: PostRemoteDataManagerOutputProtocol?
    
    
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: PostViewData?) {
        
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/checkIfLikesExist/\(postId)/\(userId)" ) else {
            return
        }
        
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( [Heart].self, from: data )
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackLikesExist(with: tasks, post: post)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    func remoteCreateLike(post: PostViewData?, userId: Int, token: String) {
        guard let ref_id = post?.id else {
            return
        }
        print("Home Remote: ")
        print(ref_id)
        print("UserId: ")
        print(userId)
        
        let param : [ String : Any ] = [
            "type_id"   : 10,
            "ref_id"    : ref_id,
            "user_id"   : userId]
        
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/create-like" ) else {
            return
        }
        
        var request = URLRequest(url: url)
        if post != nil {
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
                    let task = try decoder.decode( Heart.self, from: data )
                    print("Home Remote: ")
                    print(task)
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    
                } catch {
                    print(error)
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
    }
    
    
    func remoteDeleteLike(heart: Heart?, token: String) {
        guard let commentId = heart?.id, let refId = heart?.refID else {
            return
        }
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/delete/\(commentId)/\(refId)" ) else {
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
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    // RETORNA "TRUE" SI SE HA ELIMINADO CON EXITO.
                    self.remoteRequestHandler?.remoteCallBackDeleteLike(with: tasks)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    // DELETE POST.
    func remoteDeletePost(post: PostViewData?, token: String) {
        print("Post REMOTE")
    }
    
}
