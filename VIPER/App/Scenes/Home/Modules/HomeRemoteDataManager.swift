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
    var isPaginationOn: Bool? = false
    let apiService: APIServiceProtocol
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK:  CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK:  FUNCTIONS
    
    // GET DATA
    func remoteGetData(page: Int, isPagination:Bool, token: String){
        if isPagination {
            isPaginationOn = true
        }
        
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/\(page)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResPosts.self, from: data )
                    guard let posts = tasks.resPostImages?.posts, let totalPages = tasks.resPostImages?.totalPages else {
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
                        
                        self.models.append( viewModel )
                    }
                    
                    /*
                     * ------------- ENVIAR DATOS AL INTERACTOR -------------
                     * EN ESTE PUNTO DE DEVUELVE LOS DATOS PASANDOLE
                     * AL INTERACTOR.
                     */
                    self.remoteRequestHandler?.remoteCallBackData( with: self.models, totalPages: totalPages )
                    if isPagination {
                        self.isPaginationOn = false
                    }
                } catch {
                    print(" SearchRemoteDataManager: Error catch... ")
                }
            }
        }
        task.resume()
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
