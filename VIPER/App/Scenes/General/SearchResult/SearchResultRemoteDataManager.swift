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
    let apiService: APIServiceProtocol
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - FUNCTIONS
    func remoteGetData(token: String, filter: UserSearchBE) {
        apiService.searchResult(filter, token) { [ weak self ] ( result ) in
            switch result {
            case .success(let objec):
                guard let result = objec.userpost else { return }
                self?.remoteRequestHandler?.remoteCallBackData(userpost: result)
            case .failure(let error):
                print("Error processing data Profile \(error)")
            }
        }
    }
}
