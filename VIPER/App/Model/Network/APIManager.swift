
import UIKit

protocol ProAPIManagerProtocol: AnyObject {
    // LOGIN
     func fetchLogin(email: String, password: String, completion : @escaping (LoginToken?)->())
    
    // HOME
    func fetchPosts(page: Int, isPagination:Bool, token: String, completion : @escaping (ResPosts?)->())
    func insertLike(post: PostViewData?, userId: Int, token: String, completion : @escaping (Heart?)->())
    func homeDeleteLike(heart: Heart?, token: String, completion : @escaping (ResMessage?)->())
    func homeCheckIfLikesExist(postId: Int, userId: Int, token: String, completion: @escaping ([Heart]?) -> () )
    
}

class APIManager: NSObject, ProAPIManagerProtocol {
    
    // MARK: SHARED
    static let shared = APIManager()
    
    // MARK: URLS API
    static let _URL_login = "/api/users/login/"
    static let _URL_posts = "/api/posts/"
    static let _URL_createLike = "/api/posts/create-like/"
    static let _URL_deleteLike = "/api/posts/delete/"
    static let _URL_checkIfLikesExist = "/api/posts/checkIfLikesExist/"
    
    

    /* TODO: - LOGIN
     * ----------------- LOGINVIEW API REST -----------------
     * EN ESTE PUNTO SE VA A REALIZAR LLAMADAS AL SERVIDOR PARA
     * GESTIONAR LOS DATOS DEL MODULO "LOGINVIEW". */
     func fetchLogin(email: String, password: String, completion: @escaping (LoginToken?) -> ()) {
        let param : [ String : Any ] = [
            "email": email,
            "password" : password
        ]
        
         guard let url = URL( string: Constants.ApiRoutes.domain + APIManager._URL_login) else {
            return
        }
        
        var request = URLRequest(url: url)
        if !email.isEmpty || !password.isEmpty {
            do {
                request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: param,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpMethod = Constants.Method.httpPost
            } catch {}
        }
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let task = try decoder.decode( LoginToken.self, from: data )
                    completion(task)
                } catch {
                    print("APIMANAGER LOGIN: ERROR RESPONSE...")
                }
            }
        }
        task.resume()
    }
    
    
    
    
    /* TODO: - HOME
     * ----------------- HOMEVIEW API REST -----------------
     * EN ESTE PUNTO SE VA A REALIZAR LLAMADAS AL SERVIDOR PARA
     * GESTIONAR LOS DATOS DEL MODULO "HOMEVIEW". */
    
    // BUSCAR PUBLICACIONES
    func fetchPosts(page: Int, isPagination: Bool, token: String, completion: @escaping (ResPosts?) -> ()) {
        guard let url = URL( string: Constants.ApiRoutes.domain + APIManager._URL_posts + "\(page)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
        request.setValue("Bearer \(token)", forHTTPHeaderField: Constants.ApiRoutes.authorization)
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResPosts.self, from: data )
                    completion(tasks)
                } catch {
                    print(" SearchRemoteDataManager: Error catch... ")
                }
            } else {
                // POSIBLE ERROR.
            }
        }
        task.resume()
    }
    
    // INSERTAR "ME GUSTA" DE LA PUBLICACIÓN.
    func insertLike(post: PostViewData?, userId: Int, token: String, completion: @escaping (Heart?) -> ()) {
        guard let ref_id = post?.id else {
            return
        }
        let param : [ String : Any ] = [
            "type_id"   : 10,
            "ref_id"    : ref_id,
            "user_id"   : userId]
        
        guard let url = URL( string: Constants.ApiRoutes.domain + APIManager._URL_createLike ) else {
            return
        }
        
        var request = URLRequest(url: url)
        if post != nil {
            do {
                request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
                request.setValue("Bearer \(token)", forHTTPHeaderField: Constants.ApiRoutes.authorization)
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: param,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpMethod = Constants.Method.httpPost
            } catch {}
        }
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let task = try decoder.decode( Heart.self, from: data )
                    completion(task)
                } catch {
                    print(error)
                    print("error preccesing data Profile")
                }
            }
        }
        task.resume()
    }
    
    // ELIMINAR "ME GUSTA" DE LA PUBLICACION.
    func homeDeleteLike(heart: Heart?, token: String, completion: @escaping (ResMessage?) -> ()) {
        guard let commentId = heart?.id, let refId = heart?.refID else {
            return
        }
        guard let url = URL( string: Constants.ApiRoutes.domain + APIManager._URL_deleteLike + "\(commentId)/\(refId)" ) else {
            return
        }
        
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpDelete
        request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
        request.setValue("Bearer \(token)", forHTTPHeaderField: Constants.ApiRoutes.authorization)
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResMessage.self, from: data )
                    completion(tasks)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    // VERFIICAR SI EXISTE "EL ME GUSTA" EN LA PUBLICACIÓN.
    func homeCheckIfLikesExist(postId: Int, userId: Int, token: String, completion: @escaping ([Heart]?) -> ()) {
        guard let url = URL( string: Constants.ApiRoutes.domain + APIManager._URL_checkIfLikesExist + "\(postId)/\(userId)" ) else {
            return
        }
        
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
        request.setValue("Bearer \(token)", forHTTPHeaderField: Constants.ApiRoutes.authorization)
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( [Heart].self, from: data )
                    completion(tasks)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
   
    
    
    
    
    
    
    
    
    
    /* TODO: - GUARDAR SESION
     * ----------------- GUARDAR TOKEN -----------------
     * GUARDAR EL TOKEN EN LA APP.
     */
    func saveSesion(deUsuario objUsuario : LoginToken)  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do {
            appDelegate.loginSession = objUsuario
            let objUsuario = try JSONEncoder().encode( objUsuario )
            
            CDMKeyChain.guardarDataEnKeychain(
                try NSKeyedArchiver.archivedData(
                    withRootObject: objUsuario,
                    requiringSecureCoding: false),
                conCuenta: "CDMLogin",
                conServicio:"datosUsuario")
        } catch {
            print("Failed to save data... log: OSLog.default, type: .error")
        }
    }
}
