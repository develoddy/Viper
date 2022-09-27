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
    //let apiService: APIServiceProtocol
    let apiManager: ProAPIManagerProtocol
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK:  CONSTRUCTOR
    //init(apiService: APIServiceProtocol = APIService()) {
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    
    // MARK:  FUNCTIONS
    func remoteGetData(page: Int, isPagination:Bool, token: String) {
        if isPagination {
            isPaginationOn = true
        }
        self.apiManager.fetchPosts(page: page, isPagination: isPagination, token: token) { [weak self] response in
            if let posts = response?.resPostImages?.posts, let totalPages = response?.resPostImages?.totalPages {
                self?.remoteRequestHandler?.remoteCallBackData(with: posts, totalPages: totalPages)
                if isPagination {
                    self?.isPaginationOn = false
                }
            } else {
                // POSIBLE ERROR.
            }
        }
    }
    
    
    
    
    
    
    // GET DATA
    /*func remoteGetData(page: Int, isPagination:Bool, token: String) {
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
                    
                    let formattedItemsPost = posts.map{PostViewData(info: $0)}
                    
                    for items in formattedItemsPost {
                        
                        let formattedItemsComment = items.comments.map{CommentViewData(info: $0)}
                        
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
                                renderType: .comments( comments: formattedItemsComment )
                            )
                        )
                        
                        self.models.append( viewModel )
                    }
                    // LLAMAR AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackData( with: self.models, totalPages: totalPages )
                    if isPagination {
                        self.isPaginationOn = false
                    }
                } catch {
                    print(" SearchRemoteDataManager: Error catch... ")
                }
            } else {
                // LLAMAR AL INTERACTOR Y PASARLE EL ERROR QUE
            }
        }
        task.resume()
    }*/
    
    
    // CREATE LIKE
    func remoteCreateLike(post: PostViewData?, userId: Int, token: String) {
        guard let ref_id = post?.id else {
            return
        }
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
                    let _ = try decoder.decode( Heart.self, from: data )
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
}
