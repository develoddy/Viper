//
//  ProfileRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation

// MARK: REMOTE DATA MANAGER
class ProfileRemoteDataManager:ProfileRemoteDataManagerInputProtocol {
    
    // MARK: PROPERTIES
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    let apiService: APIServiceProtocol
    var viewModelPost: [Post] = []
    var viewModel: [User] = []
    var viewModelTasts: [ResCounter] = []
    
    
    // MARK:  CONSTRUCTOR
    init( apiService: APIServiceProtocol = APIService() ) {
        self.apiService = apiService
    }
    
    
    /*
     * ----------- PERFIL ------------
     * EN ESTE PUNTO SE OBTIENE LOS DATOS DEL PERFIL (HEADER).
     */
    func remoteGetData(id: Int, token: String) {
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/users/one/\(id)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResUser.self, from: data )
                    guard let viewModel = tasks.user else {
                        return
                    }
                    self.viewModel.append( viewModel )
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackData( with: self.viewModel )
                } catch {
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
    }
    
    
    /*
     * ----------- COUNTER ------------
     * EN ESTE PUNTO SE OBTIENE LOS DATOS DE LOS
     * CONTADORES DE PUBLICACIÓN, SEFGUIDORES Y SIGUIENDO.
     */
    func remoteGetCounter(id: Int, token: String) {
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/users/counters/one/\(id)" ) else {
            return
        }
        
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResCounter.self, from: data )
                    self.viewModelTasts.append( tasks )
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackTasts( with: self.viewModelTasts )
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    /*
     * ----------- POST USER ------------
     * EN ESTE PUNTO SE OBTIENE LOS DATOS DE
     * LAS PUBLICACIONES (GRID IMAGENES).
     */
    func remoteGetPosts(id: Int, page: Int, token: String) {
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/user/\(id)/\(page)" ) else {
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
                    guard let posts = tasks.resPostImages?.posts else {
                        return
                    }
                    
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackPosts( with: posts )
        
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    /*
     * ----------- FOLLOWING ------------
     * EN ESTE PUNTO SE OBTIENE A LA GENTE QUE SEGUIMOS.
     */
    func remoteGetFollowing(page: Int, token: String) {
        
        guard let url = URL(string: Constants.ApiRoutes.domain + "/api/follows/following/\(page)") else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResFollows.self, from: data )
                    guard let following = tasks.follows else {
                        return
                    }
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackFollowing(with: following)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func remoteGetFollowers(page: Int, token: String) {
        
        guard let url = URL(string: Constants.ApiRoutes.domain + "/api/follows/followed/\(page)") else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResFollows.self, from: data )
                    guard let follower = tasks.follows else {
                        return
                    }
                    // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                    self.remoteRequestHandler?.remoteCallBackFollowers(with: follower)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
