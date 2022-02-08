//
//  WSTranslator.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//

import UIKit

class WSTranslator: NSObject {
    
    // MARK: USERPOST TRANSLATOR RESPONSE
    // Convert Object dicctionary a Json Codable UserPost
    // Return Object Codable
    class func translateResponseUserPostBE(_ objDic: NSDictionary,
                                           completion: @escaping ((Result<UserPostData, Error>)) -> Void) {
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
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseUserPostBE)")
        }
    }
    
    // MARK: PROFILE TRANSLATOR RESPONSE
    // Convert Object dicctionary a Json Codable Explore
    // Return Object Codable
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
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseProfileBE)")
        }
    }
    
    // MARK: PROFILE TRANSLATOR RESPONSE
    // Convert Object dicctionary a Json Codable Explore
    // Return Object Codable
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
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseLikeBE)")
            completion(.failure(Error.self as! Error))
        }
    }
    
    // MARK: EXPLORE TRANSLATOR RESPONSE
    // Convert Object dicctionary a Json Codable Explore
    // Return Object Codable
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
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseExploreBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    
    // MARK: TOKEN TRANSLATOR RESPONSE
    // translateResponseTokenBE
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
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseTokenBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    // MARK: LIKED TRANSLATOR RESPONSE
    // Convert Object dicctionary a Json Codable Explore.
    // Return Object Codable.
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
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseLikedBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    
    // MARK: POST CAPTION TRANSLATOR RESPONSE
    // Convert Object dicctionary a Json Codable Explore.
    // Return Object Codable.
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
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseCaptionBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    // MARK: LOGOUT TRANSLATOR RESPONSE
    // Return Object mensaje logout.
    class func translateResponseLogOutBE(_ objDic: NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }
}

