import UIKit

// MARK: API INTERACTOR
class APIInteractor: NSObject  {
    
    // MARK: URLS API
    static let urlBase : String = Constants.ApiRoutes.domain
    static let _URL_login = "api/users/login/"
    static let _URL_posts = "api/posts/"
    static let _URL_createLike = "api/posts/create-like/"
    static let _URL_deleteLike = "api/posts/delete/"
    static let _URL_checkIfLikesExist = "api/posts/checkIfLikesExist/"
    
    /* TODO: SE APLICA LA LOGICA DE OBTENER LOS DATOS "LOGIN"
     * LLAMAR AL APIREMOTE
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE LOS DATOS BIEN FORMATEADOS AL API MANAGER. */
    @discardableResult class
    func fetchLogin( email: String?, password: String?, completion: @escaping Closures.Login, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let email = email, let password = password else { return nil }
        let params : [ String : Any ] = [
            "email": email,
            "password" : password
        ]
        // LLAMAR AL API REMOTE.
        let task = APIRemote.doPOSTToURL(url: APIInteractor.urlBase, path: self._URL_login, params: params) { response in
            let dictionaryAnswer = response.respuestaJSON as? NSDictionary
            let arrayResponse = dictionaryAnswer?["error"]
            let errorMessage = ApiErrorHandling.getErrorMessage(paraData: dictionaryAnswer)
            if arrayResponse == nil {
                if dictionaryAnswer != nil && dictionaryAnswer!.count != 0 {
                    guard let dictionaryAnswer = dictionaryAnswer else {
                        return
                    }
                    /* ----- TRADUCTOR DE DATOS A JSON -----
                     * SE LLAMA AL API TRANSLATOR PARA QUE TRADUZA EL DICCIONARIO DE DATOS A FORMATO JSON. */
                    ApiTranslator.translateLoginResponse( dictionaryAnswer ) { (result) in
                        switch result {
                        case .success(let response): completion(response)
                        case .failure(let error): processIncorrect(error.localizedDescription)
                        }
                    }
                }
            } else {
                if arrayResponse as! String == Constants.Error.unauthorized {
                    let errorMessageFinal = (dictionaryAnswer != nil && dictionaryAnswer?.count == 0) ? Constants.LogInError.logInInvalidte: errorMessage
                    processIncorrect(errorMessageFinal)
                }
            }
        }
        return task
    }
    
    
    /* TODO: SE APLICA LA LOGICA PARA OBTENER LAS PUBLICACIONES.
     * SE LLAMA AL API REMOTE.
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE TODAS LAS PUBLICACIONES BIEN FORMATEADAS AL API MANAGER. */
    @discardableResult class
    func fetchPosts(page: Int?, isPagination: Bool?, token: String?, completion: @escaping Closures.Posts, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let page = page, let token = token else { return nil }
        let params : [Any]? = nil
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: self._URL_posts + "\(page)", params: params, token: token) { response in
            if let data = response.respuestaNSData {
                ApiTranslator.translateResponsePosts(data: data) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
    
    
    /* TODO: SE APLICA LA LOGICA PARA CREAR LIKE.
     * SE LLAMA AL API REMOTE.
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE TODAS LA RESPUESTA DESPUES DE INSERTAR EL LIKES EN LA BASE DE DATOS. */
    @discardableResult class
    func insertLike(post: PostViewData?, userId: Int?, token: String?, completion: @escaping Closures.heart, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let ref_id = post?.id, let userId = userId, let token = token else { return nil }
        let params : [ String : Any ] = [
            "type_id"   : 10,
            "ref_id"    : ref_id,
            "user_id"   : userId
        ]
        // LLAMAR AL API REMOTE.
        let task = APIRemote.doPOSTTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_createLike, params: params, token: token) { response in
            let dictionaryAnswer = response.respuestaJSON as? NSDictionary
            let arrayResponse = dictionaryAnswer?["error"]
            let errorMessage = ApiErrorHandling.getErrorMessage(paraData: dictionaryAnswer)
            if arrayResponse == nil {
                if dictionaryAnswer != nil && dictionaryAnswer!.count != 0 {
                    guard let dictionaryAnswer = dictionaryAnswer else {
                        return
                    }
                    /* ----- TRADUCTOR DE DATOS A JSON -----
                     * LLAMAR AL API TRANSLATOR.
                     * SE LLAMA AL API TRANSLATOR PARA QUE TRADUZA EL DICCIONARIO DE DATOS A FORMATO JSON. */
                    ApiTranslator.translateResponseCreateLike(dictionaryAnswer) { (result) in
                        switch result {
                        case .success(let response): completion(response)
                        case .failure(let error): processIncorrect(error.localizedDescription)
                        }
                    }
                }
            } else {
                if arrayResponse as! String == Constants.Error.unauthorized {
                    let errorMessageFinal = (dictionaryAnswer != nil && dictionaryAnswer?.count == 0) ? Constants.LogInError.logInInvalidte: errorMessage
                    processIncorrect(errorMessageFinal)
                }
            }
        }
        return task
    }
    
    
    /* TODO: SE APLICA LA LOGIA PARA BORRAR LIKE.
     * SE LLAMA AL API REMOTE.
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE TODAS LA RESPUESTA DESPUES DE INSERTAR EL LIKES EN LA BASE DE DATOS. */
    @discardableResult class
    func deleteLike(heart: Heart?, token: String?, completion: @escaping Closures.resMessage, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let commentId = heart?.id, let refId = heart?.refID, let token = token else { return nil }
        let params : [Any]? = nil
        // LLAMAR AL API REMOTE
        let task = APIRemote.doDELETETokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_deleteLike + "\(commentId)/\(refId)", params: params, token: token) { response in
            let dictionaryAnswer = response.respuestaJSON as? NSDictionary
            let arrayResponse = dictionaryAnswer?["error"]
            let errorMessage = ApiErrorHandling.getErrorMessage(paraData: dictionaryAnswer)
            if arrayResponse == nil {
                // COMPROBAR QUE HAY DATOS EN EL RESPONSE
                if dictionaryAnswer != nil && dictionaryAnswer!.count != 0 {
                    guard let dictionaryAnswer = dictionaryAnswer else {
                        return
                    }
                    /* ----- TRADUCTOR DE DATOS A JSON -----
                     * LLAMAR AL API TRANSLATOR.
                     * SE LLAMA AL API TRANSLATOR PARA QUE TRADUZA EL DICCIONARIO DE DATOS A FORMATO JSON. */
                    ApiTranslator.translateResponseDeleteLike(dictionaryAnswer) { (result) in
                        switch result {
                        case .success(let response):completion(response)
                        case .failure(let error): processIncorrect(error.localizedDescription)
                        }
                    }
                }
            } else {
                if arrayResponse as! String == Constants.Error.unauthorized {
                    let errorMessageFinal = (dictionaryAnswer != nil && dictionaryAnswer?.count == 0) ? Constants.LogInError.logInInvalidte: errorMessage
                    processIncorrect(errorMessageFinal)
                }
            }
        }
        return task
    }
    
    
    /* TODO: SE APLICA LA LOGIA PARA ASABERS SI EL LIKE ESTÁ CREADO O NO.
     * LLAMAR AL API REMOTE
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE TODAS LA RESPUESTA DESPUES DE INSERTAR EL LIKES EN LA BASE DE DATOS. */
    @discardableResult class
    func checkIfLikesExist(postId: Int?, userId: Int?, token: String?, completion: @escaping Closures.checkHeart, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let postId = postId, let userId = userId, let token = token else {
            return nil
        }
        let params : [Any]? = nil
        // LLAMAR AL API REMOTE
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_checkIfLikesExist + "\(postId)/\(userId)" , params: params, token: token) { response in
            if let data = response.respuestaNSData {
                /* ----- TRADUCTOR DE DATOS A JSON -----
                 * LLAMAR AL API TRANSLATOR.
                 * SE LLAMA AL API TRANSLATOR PARA QUE TRADUZA EL DICCIONARIO DE DATOS A FORMATO JSON. */
                ApiTranslator.translateResponseCheckLike(data: data) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
}
