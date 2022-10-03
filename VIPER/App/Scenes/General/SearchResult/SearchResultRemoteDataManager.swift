//
//  SearchResultRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//  
//

import Foundation

class SearchResultRemoteDataManager:SearchResultRemoteDataManagerInputProtocol {
    
    // MARK: - PROPIERTIES
    var remoteRequestHandler: SearchResultRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    var viewModel: [User] = []
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    // MARK: - FUNCTIONS
    /*func remoteGetData(token: String, filter: UserSearchBE) {
        apiService.searchResult(filter, token) { [ weak self ] ( result ) in
            switch result {
            case .success(let objec):
                guard let result = objec.userpost else { return }
                self?.remoteRequestHandler?.remoteCallBackData(userpost: result)
            case .failure(let error):
                print("Error processing data Profile \(error)")
            }
        }
    }*/
    
    func remoteGetData(token: String, filter: String) {
        guard let url = URL(string: "http://localhost:3800/api/users/get-user-filter/\(filter)") else {
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
                    let tasks = try decoder.decode([User].self, from: data)
                    self.viewModel = tasks
                    self.remoteRequestHandler?.remoteCallBackData(user: self.viewModel)
        
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
}
