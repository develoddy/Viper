//
//  APIService.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//

import Foundation


// Define a protocol containing the signature of a function to fetch data
protocol APIServiceProtocol: AnyObject {
    func getUserPost(token: String, completion : @escaping ((Result<UserPostData, Error>)) -> ())
    func getProfile(email: String, token: String, completion : @escaping ((Result<UserPostData, Error>)) -> ())
    //func apiLike(type_id: Int, ref_id: Int, users_id: Int, isLiked: Bool, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    //func apiLiked(ref_id: Int, users_id: Int, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    //func apiPostCaptionUpdate( caption: Caption, idpost: Int, token: String, completion : @escaping ((Result<Operation, Error>)) -> ())
    
    func login(email: String?, password: String?, completion: @escaping (Bool) -> Void)
}



// MARK: APIServiceProtocol
class APIService: APIServiceProtocol {
    
    // LOGIN
    func login(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        BCApiRest.logIn( email:email, password:password ) { (objUsuario) in
            completion(true)
        } conCompletionIncorrecto: { (mensajeError) in
            completion(false)
        }
    }
    
    // HOME
    func getUserPost(token: String, completion: @escaping ((Result<UserPostData, Error>)) -> ()) {
        BCApiRest.apiUserPostBC( token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    // PROFILE
    func getProfile(email: String, token: String, completion: @escaping ((Result<UserPostData, Error>)) -> ()) {
        BCApiRest.profile( email, token ) { ( object ) in
            completion(.success( object ) )
        } conCompletionIncorrecto: { ( messageError ) in
            completion(.failure( messageError as! Error ) )
        }
    }
    
    
}
