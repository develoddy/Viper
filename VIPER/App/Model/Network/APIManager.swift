
import UIKit

protocol ProAPIManagerProtocol: AnyObject {
    // LOGIN
     func fetchLogin(email: String, password: String, completion : @escaping (LoginToken?)->())
    
    // HOME
    func fetchPosts(page: Int, isPagination:Bool, token: String, completion : @escaping (ResPosts?)->())
}

class APIManager: NSObject, ProAPIManagerProtocol {
    
    static let shared = APIManager()
    
    

    /* ----------------- LOGINVIEW API REST -----------------
     * EN ESTE PUNTO SE VA A REALIZAR LLAMADAS AL SERVIDOR PARA
     * GESTIONAR LOS DATOS DEL MODULO "LOGINVIEW"
     */
     func fetchLogin(email: String, password: String, completion: @escaping (LoginToken?) -> ()) {
        let param : [ String : Any ] = [
            "email": email,
            "password" : password
        ]
        
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/users/login") else {
            return
        }
        
        var request = URLRequest(url: url)
        if !email.isEmpty || !password.isEmpty {
            do {
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
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
    
    
    /* ----------------- HOMEVIEW API REST -----------------
     * EN ESTE PUNTO SE VA A REALIZAR LLAMADAS AL SERVIDOR PARA
     * GESTIONAR LOS DATOS DEL MODULO "HOMEVIEW"
     */
    func fetchPosts(page: Int, isPagination: Bool, token: String, completion: @escaping (ResPosts?) -> ()) {
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/\(page)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpGet
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
    
    
    
    /* ----------------- GUARDAR TOKEN -----------------
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
