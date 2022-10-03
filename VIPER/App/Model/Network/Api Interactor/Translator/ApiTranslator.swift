import UIKit

class ApiTranslator: NSObject {
    
    /* TODO: TRADUCCION DE LOGIN
     *
     */
    class func translateLoginResponse(_ objDic: NSDictionary, completion: @escaping ((Result<LoginToken, Error>)) -> Void) {
        var responseTokenBE: LoginToken?
        do {
            let jsonData:NSData = try JSONSerialization.data(withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            
            responseTokenBE = try JSONDecoder().decode(LoginToken.self, from: json)
            
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
    
    /* TODO: TRADUCCIÓN DE PUBLICACIONES
     *
     */
    // class func translateResponsePosts(_ objDic: NSDictionary, completion: @escaping ((Result<ResPosts, Error>)) -> Void) {
    class func translateResponsePosts(data: Data, completion: @escaping ((Result<ResPosts, Error>)) -> Void) {
        var posts: ResPosts?
        do {
            posts = try JSONDecoder().decode(ResPosts.self, from: data)
            if let data = posts {
                completion(.success(data))
            } else {
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseUserPostBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    /* TODO: TRADUCCIÓN DE CREAR "ME GUSTA"
     *
     */
    class func translateResponseCreateLike(_ objDic: NSDictionary, completion: @escaping ((Result<Heart, Error>)) -> Void) {
        var posts: Heart?
        do {
            let jsonData:NSData = try JSONSerialization.data( withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted ) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            posts = try JSONDecoder().decode(Heart.self, from: json)
            if let data = posts {
                completion(.success(data))
            } else {
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseUserPostBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    
    /* TODO: TRADUCCION BORRAR LIKE.
     *
     */
    class func translateResponseDeleteLike(_ objDic: NSDictionary, completion: @escaping ((Result<ResMessage, Error>)) -> Void) {
        var dataTask: ResMessage?
        do {
            let jsonData:NSData = try JSONSerialization.data( withJSONObject: objDic, options: JSONSerialization.WritingOptions.prettyPrinted ) as NSData
            guard let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8) else { return }
            guard let json = jsonString.data(using: .utf8) else { return }
            dataTask = try JSONDecoder().decode(ResMessage.self, from: json)
            if let task = dataTask {
                completion(.success(task))
            } else {
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseUserPostBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
    
    class func translateResponseCheckLike(data: Data, completion: @escaping ((Result<[Heart]?, Error>)) -> Void) {
        var dataTask: [Heart]?
        do {
            dataTask = try JSONDecoder().decode([Heart].self, from: data )
            if let task = dataTask {
                completion(.success(task))
            } else {
                completion(.failure(Error.self as! Error))
            }
        } catch {
            print("TRANSLATOR: ERROR SERVE & SWIFT DISCREPANCIA PROPERTIES (translateResponseUserPostBE)")
            completion(.failure(Error.self as! Error) )
        }
    }
}
