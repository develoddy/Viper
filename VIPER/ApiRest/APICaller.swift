//
//  APICaller.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 5/2/22.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    //func login(token: String?, password: String?, completion: @escaping (Result<ResponseTokenBE, Error>) -> Void) {
    func login(token: String?, password: String?, completion: @escaping (Result<LoginToken, Error>) -> Void) {
     
    }
    
    // MARK: Private
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        
    }
}
