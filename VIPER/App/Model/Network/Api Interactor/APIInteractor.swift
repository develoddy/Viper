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
    static let _URL_profile = "api/users/one/"
    static let _URL_profile_posts = "api/posts/user/"
    static let _URL_profile_counters = "api/users/counters/one/"
    static let _URL_profile_following = "api/follows/following/"
    static let _URL_profile_followers = "api/follows/followed/"
    
    /* TODO: SE APLICA LA LOGICA DE OBTENER LOS DATOS "LOGIN"
     * LLAMAR AL APIREMOTE
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE LOS DATOS BIEN FORMATEADOS AL API MANAGER. */
    @discardableResult class
    func fetchLogin( email: String?, password: String?, completion: @escaping Closures.Login, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let email = email, let password = password else { return nil }
        let params : [ String : Any ] = [
            "email": email,
            "password": password
        ]
        // LLAMAR AL API REMOTE.
        let task = APIRemote.doPOSTToURL(url: APIInteractor.urlBase, path: self._URL_login, params: params) { response in
            if let data = response.respuestaNSData {
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: LoginToken.self) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
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
        // LLAMAR AL API REMOTE.
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: self._URL_posts + "\(page)", params: params, token: token) { response in
            if let data = response.respuestaNSData {
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: ResPosts.self) { result in
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
            "type_id": 10,
            "ref_id": ref_id,
            "user_id": userId
        ]
        // LLAMAR AL API REMOTE.
        let task = APIRemote.doPOSTTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_createLike, params: params, token: token) { response in
            if let data = response.respuestaNSData {
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: Heart.self) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
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
            if let data = response.respuestaNSData {
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: ResMessage.self) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
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
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: [Heart].self) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
    
    /* TODO: SE APLICA LA LOGIA PARA OBTENER LOS DATOS DEL PERFIL
     * LLAMAR AL API REMOTE
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE TODAS LA RESPUESTA DESPUES DE INSERTAR EL LIKES EN LA BASE DE DATOS. */
    @discardableResult class
    func fetchProfile(id: Int?, token: String?, completion: @escaping Closures.resUser, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let id = id, let token = token else {
            return nil
        }
        let params : [Any]? = nil
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_profile + "\(id)" , params: params, token: token) { response in
            if let data = response.respuestaNSData {
                ApiTranslator.translate(data: data, modelToDecode: ResUser.self) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
    
    /* TODO: SE APLICA LA LOGIA PARA OBTENER LAS PUBLICACIONES DEL PERFIL
     * LLAMAR AL API REMOTE
     * EN ESTE PUNTO EL API INTERACTOR SE ENCARGA DE PASARLE TODAS LA RESPUESTA DESPUES DE INSERTAR EL LIKES EN LA BASE DE DATOS. */
    @discardableResult class
    func fetchProfilePosts(id: Int?, page: Int?, token: String?, completion: @escaping Closures.Posts, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let id = id, let page = page, let token = token else {
            return nil
        }
        let params : [Any]? = nil
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_profile_posts + "\(id)/\(page)", params: params, token: token) { response in
            if let data = response.respuestaNSData {
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: ResPosts.self) { result in
                    switch result {
                    case .success(let response): completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
    
    
    // OBETENER LOS CONTADORES DEL PERFIL BIEN FORMATEADO
    // Y PASARSELO AL API MANAGER.
    @discardableResult class
    func fetchProfileCounters(id: Int?, token: String?, completion: @escaping Closures.resCounter, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let id = id, let token = token else {
            return nil
        }
        let params : [Any]? = nil
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_profile_counters + "\(id)", params: params, token: token) { response in
            if let data = response.respuestaNSData {
                // LLAMAR AL API TRANSLATAROR.
                ApiTranslator.translate(data: data, modelToDecode: ResCounter.self) { result in
                    switch result {
                    case .success(let response):completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
    
    // OBTENER FOLLOWINGS.
    @discardableResult class
    func fetchProfileFollowing(page: Int?, token: String?, completion: @escaping Closures.resFollows, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let page = page, let token = token else {
            return nil
        }
        let params : [Any]? = nil
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_profile_following + "\(page)", params: params, token: token) { response in
            if let data = response.respuestaNSData {
                ApiTranslator.translate(data: data, modelToDecode: ResFollows.self) { result in
                    switch result {
                    case .success(let response):completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
    
    // OBTENER FOLLOWERS.
    @discardableResult class
    func fetchProfileFollowers(page: Int?, token: String?, completion: @escaping Closures.resFollows, processIncorrect: @escaping Closures.MessageError) -> URLSessionDataTask? {
        guard let page = page, let token = token else {
            return nil
        }
        let params : [Any]? = nil
        let task = APIRemote.doGETTokenToURL(url: APIInteractor.urlBase, path: APIInteractor._URL_profile_followers + "\(page)", params: params, token: token) { response in
            if let data = response.respuestaNSData {
                ApiTranslator.translate(data: data, modelToDecode: ResFollows.self) { result in
                    switch result {
                    case .success(let response):completion(response)
                    case .failure(let error): processIncorrect(error.localizedDescription)
                    }
                }
            }
        }
        return task
    }
}
