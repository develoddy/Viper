//
//  WSApiRest.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//


import UIKit

// MARK: WSApiRest -> WSender
class WSApiRest: NSObject {
    
    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.domain as NSString
    
    // MARK: URLS
    //static let _URL_logout      = "api//logout"
    //static let _URL_login       = "api/auth/login"
    //static let _URL_signup      = "api/signup"
    static let _URL_userpost    = "api/posts/"
    static let _URL_profile     = "api/users/one/"
//    static let _URL_profile     = "api/home/profile"
//    static let _URL_explore     = "api/home/explore"
//    static let _URL_like        = "api/likes/insert"
//    static let _URL_liked       = "api/likes/liked"
//    static let _URL_caption     = "api/post/updateCaption"
    
    // NUEVO A API - NODEJS
    static let _URL_login       = "api/users/login"

    // MARK: LOGOUT
    /*@discardableResult
    class func sesionSignOut(_ token: String,
                             conCompletionCorrecto completionCorrecto: @escaping Closures.LogOut,
                             error procesoIncorrecto: @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [Any]? = nil
        return WSenderToken.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase,
                                             conPath: _URL_logout as NSString,
                                             conParametros: dic,  conToken: token) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WSTranslator.translateResponseLogOutBE(diccionarioRespuesta!)
                    completionCorrecto(objUsuario)
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }*/
    
    // MARK: LOGIN
    @discardableResult
    class func login(
        email: String?,
        password: String?,
        conCompletionCorrecto completionCorrecto : @escaping Closures.Login,
        error procesoIncorrecto: @escaping Closures.MessageError ) -> URLSessionDataTask? {
        
        guard let email = email, let password = password else { return nil}
        let dic : [String : Any] = [
            "email": email,
            "password": password,
            "typedevice": 1,
            "tokendevice": "Se debe enviar el token push del dispositivo"]
        
        // LLAMADA AL POST TO URL
        return WSenderSimple.doPOSTToURL(
            conURL: self.CDMWebModelURLBase,
            conPath: _URL_login as NSString,
            conParametros: dic) {(objRespuesta) in
                
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta?["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    
                    WSTranslator.translateResponseTokenBE( diccionarioRespuesta ) { ( result ) in
                        switch result {
                            case .success(let userPost): completionCorrecto(userPost)
                            case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = ( diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0 ) ? Constants.LogInError.logInInvalidte: mensajeError
                procesoIncorrecto( mensajeErrorFinal )
            }
        }
    }
    
    
    /*
    // MARK: SIGN IN
    @discardableResult
    class func sesionSignIn(_ objUser: UserBE,
                            conCompletionCorrecto completionCorrecto: @escaping Closures.Login,
                            error procesoIncorrecto: @escaping Closures.MessageError) -> URLSessionDataTask? {
        let dic : [String : Any] = [
            "name": objUser.name!,
            "username": objUser.username!,
            "email": objUser.email!,
            "password": objUser.password!,
            "typedevice": 1,
            "tokendevice": "Se debe enviar el token push del dispositivo"]
        
        return WSenderSimple.doPOSTToURL(conURL: self.CDMWebModelURLBase,
                                         conPath: _URL_signup as NSString,
                                         conParametros: dic) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                        switch result {
                            case .success(let userPost): completionCorrecto(userPost)
                            case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }*/

    // MARK: USERPOST A CALL IS MDADE TO THE BACKEND.
    @discardableResult class
    func startApiUserPost(_ token                                 : String?                        ,
                          conCompletionCorrecto completionCorrecto: @escaping Closures.userPost    ,
                          error procesoIncorrecto                 : @escaping Closures.MessageError) -> URLSessionDataTask? {
        let dic : [Any]? = nil
        
        let result = WSenderToken.doGETTokenToURL(conURL: WSApiRest.CDMWebModelURLBase,
                                                  conPath: _URL_userpost as NSString,
                                                  conParametros: dic,
                                                  conToken: token ?? "") {(objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta?["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseUserPostBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return result
    }
    
    
    // MARK: PROFILE A CALL IS MDADE TO THE BACKEND
    @discardableResult class func startProfile(_ id: Int,
                                               _ token: String?,
                                               conCompletionCorrecto completionCorrecto: @escaping Closures.userFollow,
                                               error procesoIncorrecto: @escaping Closures.MessageError) -> URLSessionDataTask? {
        /*let dic : [String : Any] = [
            "id": id,
            "typedevice": 1,
            "tokendevice": "Se debe enviar el token push del dispositivo"]*/
        let dic : [String : Any] = ["userId": id]
        let resultSearch = WSenderToken.doGETTokenToURL(conURL: self.CDMWebModelURLBase,
                                                         conPath: (_URL_profile +  "\(id)" ) as NSString,
                                                         conParametros: dic,
                                                         conToken: token ?? "") {(objRespuesta) in
            
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseProfileBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userFollow): completionCorrecto(userFollow)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }
    
    
    // MARK: LIKES A CALL IS MDADE TO THE BACKEND
    /*@discardableResult class func startLike(_ type_id: Int,
                                            _ ref_id: Int,
                                            _ users_id: Int,
                                            _ isLiked: Bool,
                                            _ token: String?,
                                            conCompletionCorrecto completionCorrecto : @escaping Closures.Message,
                                            error procesoIncorrecto                  : @escaping Closures.MessageError) -> URLSessionDataTask? {
        let dic : [String : Any] = [
            "type_id": type_id,
            "ref_id": ref_id,
            "users_id": users_id,
            "isLiked": isLiked,
            "typedevice": 1,
            "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSenderToken.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase,
                                                         conPath: _URL_like as NSString,
                                                         conParametros: dic,
                                                         conToken: token ?? "") {(objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseLikeBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let message): completionCorrecto(message)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }
    
    
    // MARK: EXPLORE A CALL IS MDADE TO THE BACKEND
    @discardableResult class func startSearch(_ objSearch: UserSearchBE,
                                              _ token: String?,
                                              conCompletionCorrecto completionCorrecto : @escaping Closures.userPost,
                                              error procesoIncorrecto: @escaping Closures.MessageError) -> URLSessionDataTask? {
        let dic : [String : Any] = [
            "name": objSearch.name ?? "",
            "typedevice": 1,
            "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSenderToken.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase,
                                                         conPath: _URL_explore as NSString,
                                                         conParametros: dic,
                                                         conToken: token ?? "" ) {(objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseExploreBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }
    
    // MARK: LIKED A CALL IS MDADE TO THE BACKEND.
    @discardableResult class func startLiked(_ ref_id: Int,
                                             _ users_id: Int,
                                             _ token: String?,
                                             conCompletionCorrecto completionCorrecto: @escaping Closures.Message,
                                             error procesoIncorrecto: @escaping Closures.MessageError) -> URLSessionDataTask? {
        let dic : [String : Any] = [
            "ref_id": ref_id,
            "users_id": users_id,
            "typedevice": 1,
            "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSenderToken.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase,
                                                         conPath: _URL_liked as NSString,
                                                         conParametros: dic,
                                                         conToken: token ?? "") {(objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseLikedBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                            case .success(let message): completionCorrecto(message)
                            case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }
    

    
    // MARK: POST CAPTION UPDATE MDADE TO THE BACKEND.
    @discardableResult class func startPostCaptionUpdate(_ caption: Caption,
                                                         _ idpost: Int,
                                                         _ token: String?,
                                                         conCompletionCorrecto completionCorrecto: @escaping Closures.Message,
                                                         error procesoIncorrecto: @escaping Closures.MessageError) -> URLSessionDataTask? {
        let dic : [String : Any] = [
            "content": caption.content ?? "",
            "typedevice": 1 ,
            "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSenderToken.doPUTTokenToURL(conURL: self.CDMWebModelURLBase,
                                                        conPath: _URL_caption+"/"+"\(idpost)" as NSString,
                                                        conParametros: dic,
                                                        conToken: token ?? "") {(objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta?["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseCaptionBE(diccionarioRespuesta) {(result) in
                        switch result {
                            case .success(let message): completionCorrecto(message)
                            case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }
     */
    
    
    
    // MARK: MANJERO DE MENSAJE DE ERRORES
    class func obtenerMensajeDeError(paraData data : NSDictionary?) -> String {
        var mensajeError = Constants.LogInError.mensajeError
        if data != nil && data?["data_error"] != nil  {
            let dataError = data?["data_error"] as? NSDictionary
            if dataError != nil && dataError?["msg"] != nil {
                mensajeError = dataError?["msg"] as! String
            }
        }
        return mensajeError
    }
     
   
}
