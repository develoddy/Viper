//
//  LoginRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation

class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    // MARK: - PROPERTIES
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    let apiService: APIServiceProtocol

    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    // LLAMAR AL SERVICIO Y OBTENER LOS DATOS
    func remoteGetData(email: String?, password: String?) {
        apiService.login(email: email, password: password) { success in
           self.remoteRequestHandler?.remoteCallBackData(success: success)
        }
        
        //        guard let _email = email, let _password = password else {return}
        //        let postBody = ["email": _email, "password": _password]
        //        //let notesEndpoint = URL(string: "https://develoddy.com/api/auth/login")!
        //
        //        let json = "https://develoddy.com/api/auth/login?"
        //        guard let url = URL(string: json) else {
        //            print("Invalid URL.")
        //            return
        //        }
        //
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "POST"
        //
        //        request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: [])
        //        request.addValue("Tue, 08 Feb 2022 09:33:51 GMT", forHTTPHeaderField: "Date")
        //        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        //        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //        request.addValue("no-cache", forHTTPHeaderField: "pragma")
        //        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        //        request.addValue("PostmanRuntime/7.29.0", forHTTPHeaderField: "User-Agent")
        //        request.httpShouldHandleCookies = false
        //
        //
        //        //let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //        URLSession.shared.dataTask(with: request) { data, response, error in
        //                if let error = error {
        //                    fatalError("Network error: " + error.localizedDescription )
        //                }
        //                guard let response = response as? HTTPURLResponse else {
        //                    fatalError("Not a HTTP response")
        //                }
        //                guard response.statusCode >= 200, response.statusCode < 300 else {
        //                    fatalError("Invalid HTTP status code: \(response.statusCode)")
        //                }
        //                guard let data = data else {
        //                    print("No data : \(error?.localizedDescription ?? "Unknown error").")
        //                    return
        //                }
        //            print("DATA: \(data)")
        //
        //        }.resume()
        //        //task.resume()
    }
}
