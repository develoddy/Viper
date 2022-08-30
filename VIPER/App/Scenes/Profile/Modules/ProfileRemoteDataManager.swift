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
    //var user: User?
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - FUNCTIONS
    
    func remoteGetData(id: Int, token: String) {
        self.apiService.getProfile(id: id, token: token) { result in
            switch result {
            case .success( let data ):
                guard let viewModel = data.user else { return }
                self.viewModel.append(viewModel)
                // ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                self.remoteRequestHandler?.remoteCallBackData(with: self.viewModel)
            case .failure( let error ):
                print("error preccesing data Profile \(error)")
            }
        }
    }
    
    
    
    func remoteGetCounter(id: Int, token: String) {
        guard let url = URL(string: "http://localhost:3800/api/users/counters/one/\(id)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let tasks = try decoder.decode(ResCounter.self, from: data)
                    self.viewModelTasts.append(tasks)
                    self.remoteRequestHandler?.remoteCallBackTasts(with: self.viewModelTasts)
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    func remoteGetPosts(id: Int, page: Int, token: String) {
        guard let url = URL(string: "http://localhost:3800/api/posts/user/\(id)/\(page)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let tasks = try decoder.decode(ResPostImages.self, from: data)
                    guard let posts = tasks.posts else {
                        return
                    }
                    print("Remote count: ")
                    print(posts.count)
                    self.viewModelPost = posts
                    self.remoteRequestHandler?.remoteCallBackPosts(with: self.viewModelPost)
        
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func remoteGetData(id: Int, token: String) {
//        apiService.getProfile(id: id, token: token) { [ weak self ] ( result ) in
//            switch result {
//            case .success( let listOf ):
//                guard let viewModel = listOf.user else {
//                    return
//                }
//                //self?.viewModel = viewModel
//                self?.viewModel.append(viewModel)
//                // TODO: ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
//                self?.remoteRequestHandler?.remoteCallBackData(with: self?.viewModel ?? [])
//
//            case .failure(let error):
//                print("Error processing data Profile \(error)")
//            }
//        }
//    }
    
}
