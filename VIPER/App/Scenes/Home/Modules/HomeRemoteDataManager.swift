//
//  HomeRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    // MARK:  PROPIERTIES
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    let apiService: APIServiceProtocol
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK:  CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK:  FUNCTIONS
    
    // GET DATA
    func remoteGetData(token: String) {
        
        apiService.getUserPost( token: token ) { [ weak self ] ( result ) in
            switch result {
            case .success(let listOf):
                
                // SE OBTIENE LAS PUBLICACIONES
                guard let posts = listOf.resPostImages?.posts else {
                    return
                }
                
                /*
                 * ------------- RECORRER LAS PUBLICACIONES -------------
                 * EN ESTE PUNTO SE RECORRE TODAS LAS PUBLICACIONES Y
                 * GUARDANDO LOS DATOS EN UN MODELO
                 */
                for items in posts {
                    
                    let viewModel = HomeFeedRenderViewModel(
                        header: PostRenderViewModel(
                            renderType: .header( provider: items )
                        ),
                        post: PostRenderViewModel(
                            renderType: .primaryContent( provider: items )
                        ),
                        actions: PostRenderViewModel(
                            renderType: .actions( provider: items )
                        ),
                        descriptions: PostRenderViewModel(
                            renderType: .descriptions( post: items )
                        ),
                        comments: PostRenderViewModel(
                            renderType: .comments( comments: items.comments ?? [] )
                        )
                        /*footer: PostRenderViewModel(
                            renderType: .footer( footer: items )
                        )*/
                    )
                    
                    self?.models.append( viewModel )
                }
                
                guard let models = self?.models else {
                    return
                }
                
                /*
                 * ------------- ENVIAR DATOS AL INTERACTOR -------------
                 * EN ESTE PUNTO DE DEVUELVE LOS DATOS PASANDOLE
                 * AL INTERACTOR.
                 */
                self?.remoteRequestHandler?.remoteCallBackData( with: models )
                
            case .failure(let error):
                print("Error processing  data Home \(error)")
            }
        }
    }
    
    
    // CREATE LIKE
    func remoteCreateLike(post: Post?, userId: Int, token: String) {
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
    
    
    // DELETE LIKE
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
    
    
    // VERIFICAR SI EL LIKE EXISTE EN LA BASE DE DATOS.
    func remoteCheckIfLikesExist(postId: Int, userId: Int, token: String, post: Post?) {
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
}
