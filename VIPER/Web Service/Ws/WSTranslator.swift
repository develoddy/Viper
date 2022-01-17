//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//

import UIKit

class WSTranslator: NSObject {
    
    //MARK: USERPOST TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable UserPost
    ///Return Object Codable
    class func translateResponseUserPostBE(_ objDic: NSDictionary, completion: @escaping ((Result<UserPostData, Error>)) -> Void) {
        var userPost: UserPostData?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            userPost = try JSONDecoder().decode(UserPostData.self, from: json)
            if let userPost = userPost {
                completion(.success(userPost))
            } else {
                completion(.failure(Error.self as! Error))
                print("Failed to pase")
            }
        } catch {
            print("--- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseUserPostBE ==> error")
        }
    }
    
    //MARK: PROFILE TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseProfileBE(_ objDic: NSDictionary, completion: @escaping ((Result<UserPostData, Error>)) -> Void) {
        var userPost: UserPostData?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            
            userPost = try JSONDecoder().decode(UserPostData.self, from: json)
            if let userPost = userPost {
                completion(.success(userPost))
            } else {
                completion(.failure(Error.self as! Error))
                print("Failed to pase")
            }
        } catch {
            print("--- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseProfileBE ==> error")
        }
    }
    
    //MARK: PROFILE TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseLikeBE(_ objDic: NSDictionary, completion: @escaping ((Result<Operation, Error>)) -> Void) {
        var operation: Operation?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            operation = try JSONDecoder().decode(Operation.self, from: json)
            if let operation = operation {
                completion(.success(operation))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseLikeBE ==> error")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    //MARK: EXPLORE TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore
    ///Return Object Codable
    class func translateResponseExploreBE(_ objDic: NSDictionary, completion: @escaping ((Result<UserPostData, Error>)) -> Void) {
        var userPost: UserPostData?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            userPost = try JSONDecoder().decode(UserPostData.self, from: json)
            
            if let userPost = userPost {
                completion(.success(userPost))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print("--- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseExploreBE ==> error")
        }
    }
    
    
    //MARK: TOKEN TRANSLATOR RESPONSE.
    ///translateResponseTokenBE
    class func translateResponseTokenBE(_ objDic: NSDictionary, completion: @escaping ((Result<ResponseTokenBE, Error>)) -> Void) {
        var responseTokenBE: ResponseTokenBE?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            responseTokenBE = try JSONDecoder().decode(ResponseTokenBE.self, from: json)
            if let responseTokenBE = responseTokenBE {
                completion(.success(responseTokenBE))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            print(" --- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseTokenBE ==> error")
        }
    }
    
    //MARK: LIKED TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore.
    ///Return Object Codable.
    class func translateResponseLikedBE(_ objDic: NSDictionary, completion: @escaping ((Result<Operation, Error>)) -> Void) {
        var operation: Operation?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            operation = try JSONDecoder().decode(Operation.self, from: json)
            if let operation = operation {
                completion(.success(operation))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            ///print("--- translateResponseLikedBE ::: error")
            print(" --- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseTokenBE ==> error")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    
    //MARK: POST CAPTION TRANSLATOR RESPONSE.
    ///Convert Object dicctionary a Json Codable Explore.
    ///Return Object Codable.
    class func translateResponseCaptionBE(_ objDic: NSDictionary, completion: @escaping ((Result<Operation, Error>)) -> Void) {
        var operation: Operation?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            operation = try JSONDecoder().decode(Operation.self, from: json)
            if let operation = operation {
                completion(.success(operation))
            } else {
                completion(.failure(Error.self as! Error) )
                print("Failed to pase")
            }
        } catch {
            ///print("--- translateResponseLikedBE ::: error")
            print(" --- Coding Error o discrepancia entre propiedades de Lravel y Swift ==> translateResponseCaptionBE ==> error")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    //MARK: LOGOUT TRANSLATOR RESPONSE.
    ///Return Object mensaje logout.
    class func translateResponseLogOutBE(_ objDic: NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
}

