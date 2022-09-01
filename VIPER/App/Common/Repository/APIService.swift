//
//  APIService.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//

import Foundation


// Define a protocol containing the signature of a function to fetch data
protocol APIServiceProtocol: AnyObject {
    func getUserPost(token: String, completion : @escaping ((Result<ResPosts, Error>)) -> ())
    //func getProfile(id: Int, token: String, completion : @escaping ((Result<ResUF, Error>)) -> ())
    func getCounter(id: Int, token: String, completion: @escaping ((Result<ResCounter, Error>)) -> ())
    
    //func apiLike(type_id: Int, ref_id: Int, users_id: Int, isLiked: Bool, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    //func apiLiked(ref_id: Int, users_id: Int, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    //func apiPostCaptionUpdate( caption: Caption, idpost: Int, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    
    func login(email: String?, password: String?, completion: @escaping (Bool) -> Void)
    //func searchResult(_ objSearch: UserSearchBE, _ token: String?, completion : @escaping ((Result<UserPostData, Error>)) -> ())
}

// MARK: APIServiceProtocol
class APIService: APIServiceProtocol {
   
    
    // SEARCH
    /*func searchResult(_ objSearch: UserSearchBE, _ token: String?, completion: @escaping ((Result<UserPostData, Error>)) -> ()) {
        BCApiRest.search(objSearch, token) {(object) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }*/
    
    // LOGIN
    func login(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        BCApiRest.login(email:email, password:password) {(objUsuario) in
            completion(true)
        } conCompletionIncorrecto: { (mensajeError) in
            completion(false)
        }
    }
    
    // HOME
    //func getUserPost(token: String, completion: @escaping ((Result<UserPostData, Error>)) -> ()) {
    func getUserPost(token: String, completion: @escaping ((Result<ResPosts, Error>)) -> ()) {
        BCApiRest.apiUserPostBC( token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    /*func getUserPost(token: String, completion: @escaping ((Result<ResPostImages, Error>)) -> ()) {
        return ResPostImages
    }*/
    
    // PROFILE
    /*func getProfile(id: Int, token: String, completion: @escaping ((Result<ResUF, Error>)) -> ()) {
        BCApiRest.profile( id, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }*/
    
    // PROFILE
    //func getProfile(token: String) {
//    func getProfile(id: Int, token: String, completion: @escaping ((Result<ResUF, Error>)) -> ()) {
//
//        guard let url = URL(string: "http://localhost:3800/api/users/one/\(id)") else{ return }
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "GET"
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//
//        let task = URLSession.shared.dataTask(with: request) {
//                data, response, error in
//
//                let decoder = JSONDecoder()
//
//                if let data = data{
//                    do{
//                        let tasks = try decoder.decode(ResUF.self, from: data)
//                        completion(.success(tasks))
//                        /*tasks.forEach{ i in
//                            print(i.user as Any)
//                        }*/
//                    }catch{
//                        print(error)
//                        completion(.failure(error))
//                    }
//                }
//            }
//            task.resume()
//    }
    
    func getCounter(id: Int, token: String, completion: @escaping ((Result<ResCounter, Error>)) -> ()) {
//        // get(this.url + "users/counters/one/" + userId)
//        guard let url = URL(string: <#T##String#>) else {
//            <#statements#>
//        }
    }
}
