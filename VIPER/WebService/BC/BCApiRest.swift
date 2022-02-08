//
//  BCApiRest.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//

import UIKit

// MARK: BCApiRest -> WSApiRest
class BCApiRest: NSObject {
    
    //MARK: Close session
    @discardableResult class func logOut(_ token                                     : String?                          ,
                                         conCompletionCorrecto completioCorrecto     : @escaping Closures.LogOut        ,
                                         conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError  ) -> URLSessionDataTask? {
        return WSApiRest.sesionSignOut(token!, conCompletionCorrecto: { ( objUser ) in
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
    }
    
    //MARK: Start session
    @discardableResult class func logIn(
        email: String?,
        password: String?,
        conCompletionCorrecto completioCorrecto: @escaping Closures.Login,
        conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError) -> URLSessionDataTask? {
            if email?.count == 0 {
                completionIncorrecto("You need enter your email")
                return nil
            }
            if password?.count == 0 {
                completionIncorrecto("You need enter your password")
                return nil
            }
        return WSApiRest.iniciarSesion(email:email, password: password, conCompletionCorrecto: {(objUser) in
            BCApiRest.guardarSesion(deUsuario: objUser)
            completioCorrecto(objUser)
        }, error: {(mensajeError) in
            completionIncorrecto(mensajeError)
        })
    }
    
    
    //MARK: signIn
    @discardableResult class func signIn(_ objUser                                   : UserBE                          ,
                                         conCompletionCorrecto completioCorrecto     : @escaping Closures.Login        ,
                                         conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        if objUser.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        if objUser.username?.count == 0 {
            completionIncorrecto("You need enter your username")
            return nil
        }
        if objUser.email?.count == 0 {
            completionIncorrecto("You need enter your email")
            return nil
        }
        if objUser.password?.count == 0 {
            completionIncorrecto("You need enter your password")
            return nil
        }
            
        return WSApiRest.sesionSignIn( objUser, conCompletionCorrecto: { ( objUser ) in
            BCApiRest.guardarSesion( deUsuario: objUser )
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto( mensajeError )
        })
    }
    
    //MARK: Guardar session
    class func guardarSesion(deUsuario objUsuario : ResponseTokenBE) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do {
            appDelegate.objUsuarioSesion = objUsuario
            let objUsuario = try JSONEncoder().encode( objUsuario ) ///encode data
            CDMKeyChain.guardarDataEnKeychain(
                try NSKeyedArchiver.archivedData(withRootObject: objUsuario, requiringSecureCoding: false),conCuenta: "CDMLogin", conServicio:"datosUsuario")
        } catch {
            print("Failed to save data... log: OSLog.default, type: .error")
        }
    }
    
    // MARK: USERPOST.
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el token
    /// Return object userpost o de lo contrario un mensaje de error.
    @discardableResult class
    public func apiUserPostBC(_ token                                     : String?                         ,
                              conCompletionCorrecto completioCorrecto     : @escaping Closures.userPost     ,
                              conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        let result = WSApiRest.startApiUserPost( token, conCompletionCorrecto: { ( data ) in
            completioCorrecto( data )
        }, error: { ( messageError ) in
            completionIncorrecto( messageError )
        })
        return result
    }
    
    //MARK: PROFILE.
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el objeto userSearch y el token
    /// Return object userpost o de lo contrario un mensaje de error.
    @discardableResult class func profile(_ email: String,
                                          _ token: String?,
                                          conCompletionCorrecto completioCorrecto: @escaping Closures.userPost,
                                          conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        if email.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        
        let resultSearch = WSApiRest.startProfile(email, token!, conCompletionCorrecto: { (objExplore) in
            completioCorrecto(objExplore)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        
        return resultSearch
    }
    
    
    //MARK: LIKE.
    /// Vamos a llamar al backend para insertar o eliminar un like..
    /// Esta funcion recibe por parametros idpost, idUser
    /// Return messager.
    @discardableResult class func like(_ type_id: Int,
                                       _ ref_id: Int,
                                       _ users_id: Int,
                                       _ isLiked: Bool,
                                       _ token: String?,
                                       conCompletionCorrecto completioCorrecto: @escaping Closures.message,
                                       conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let resultSearch = WSApiRest.startLike(type_id,
                                               ref_id,
                                               users_id,
                                               isLiked,
                                               token!,
                                               conCompletionCorrecto: { ( objLike ) in
            completioCorrecto( objLike )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
        return resultSearch
    }
    
    //MARK: EXPLORE.
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el objeto userSearch y el token
    /// Return object userpost o de lo contrario un mensaje de error.
    @discardableResult class func search(_ objSearch: UserSearchBE,
                                         _ token: String?,
                                         conCompletionCorrecto completioCorrecto: @escaping Closures.userPost,
                                         conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        if objSearch.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        
        let resultSearch = WSApiRest.startSearch(objSearch, token!, conCompletionCorrecto: { ( objExplore ) in
            completioCorrecto(objExplore)
        }, error: { (mensajeError) in
            print("mensajeError")
            completionIncorrecto(mensajeError)
        })
        
        return resultSearch
    }
    
    
    //MARK: LIKED.
    /// Vamos a llamar al backend para insertar o eliminar un like..
    /// Esta funcion recibe por parametros idpost, idUser
    /// Return message.
    @discardableResult class func liked(_ ref_id: Int,
                                        _ users_id: Int,
                                        _ token: String?,
                                       conCompletionCorrecto completioCorrecto: @escaping Closures.message,
                                       conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let resultSearch = WSApiRest.startLiked(ref_id,
                                                users_id,
                                                token!,
                                                conCompletionCorrecto: { ( objLike ) in
            completioCorrecto( objLike )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
        return resultSearch
    }
    
    
    //MARK: CAPTION.
    /// Vamos a llamar al backend para actualizar el dato del caption del post.
    /// Esta funcion recibe por parametros: caption, idpost y token.
    /// Return message.
    @discardableResult class func postCaptionUpdate(_ caption: Caption,
                                                    _ idpost: Int,
                                                    _ token: String?,
                                                   conCompletionCorrecto completioCorrecto: @escaping Closures.message,
                                                   conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let resultSearch = WSApiRest.startPostCaptionUpdate(caption,
                                                            idpost,
                                                            token!,
                                                            conCompletionCorrecto: { ( objCaption ) in
            completioCorrecto( objCaption )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
        return resultSearch
    }
}

