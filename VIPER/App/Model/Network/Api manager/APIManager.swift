import UIKit

protocol ProAPIManagerProtocol: AnyObject {
    func fetchLogin(email: String?, password: String?, completion : @escaping (Result<LoginToken?, Error>)->())
    func fetchPosts(page: Int?, isPagination:Bool?, token: String?, completion : @escaping (Result<ResPosts?, Error>)->())
    func insertLike(post: PostViewData?, userId: Int?, token: String?, completion : @escaping (Result<Heart?, Error>)->())
    func deleteLike(heart: Heart?, token: String?, completion : @escaping (Result<ResMessage?, Error>)->())
    func checkIfLikesExist(postId: Int?, userId: Int?, token: String?, completion: @escaping (Result<[Heart]?, Error>) -> ())
    func fetchProfile(id: Int?, token: String?, completion: @escaping (Result<ResUser?, Error>) -> () )
    func fetchProfilePosts(id: Int?, page: Int?, token: String?, completion: @escaping (Result<ResPosts?, Error>) -> ())
    func fetchProfileCounters(id:Int?, token:String?, completion: @escaping (Result<ResCounter?, Error>) -> ())
    func fetchProfileFollowing(page: Int?, token:String?, completion: @escaping (Result<ResFollows?, Error>) -> ())
    // func remoteGetFollowers(page: Int, token: String)
    func fetchProfileFollowers(page: Int?, token:String?, completion: @escaping (Result<ResFollows?, Error>) -> ())
}

// MARK: API MANAGER
class APIManager: NSObject, ProAPIManagerProtocol {
    
    
   
    
    // MARK: SHARED
    static let shared = APIManager()
    
    func fetchLogin(email: String?, password: String?, completion: @escaping (Result<LoginToken?, Error>) -> ()) {
        APIInteractor.fetchLogin(email: email, password: password) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure( messageError as! Error))
        }
    }
    
    // BUSCAR PUBLICACIONES
    func fetchPosts(page: Int?, isPagination: Bool?, token: String?, completion: @escaping (Result<ResPosts?, Error>) -> ()) {
        APIInteractor.fetchPosts(page: page, isPagination: isPagination, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }

    }
    
    // INSERTAR "ME GUSTA" DE LA PUBLICACIÓN.
    func insertLike(post: PostViewData?, userId: Int?, token: String?, completion: @escaping (Result<Heart?, Error>) -> ()) {
        APIInteractor.insertLike(post: post, userId: userId, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // ELIMINAR "ME GUSTA" DE LA PUBLICACION.
    func deleteLike(heart: Heart?, token: String?, completion: @escaping (Result<ResMessage?, Error>) -> ()) {
        // LLAMAR AL API INTERACTOR.
        APIInteractor.deleteLike(heart: heart, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // VERFIICAR SI EXISTE "EL ME GUSTA" EN LA PUBLICACIÓN.
    func checkIfLikesExist(postId: Int?, userId: Int?, token: String?, completion: @escaping (Result<[Heart]?, Error>) -> ()) {
        // LLAMAR AL API INTERACTOR
        APIInteractor.checkIfLikesExist(postId: postId, userId: userId, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // USCAR LOS DATOS DEL PERFIL.
    func fetchProfile(id: Int?, token: String?, completion: @escaping (Result<ResUser?, Error>) -> ()) {
        APIInteractor.fetchProfile(id: id, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // BUSCAR LAS PUBLICACIONES DE CADA PERFIL.
    func fetchProfilePosts(id: Int?, page: Int?, token: String?, completion: @escaping (Result<ResPosts?, Error>) -> ()) {
        APIInteractor.fetchProfilePosts(id: id, page: page, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // BUSCAR LOS CONTADORES DE "POST", "FOLLOW", "FOLLOWING"
    func fetchProfileCounters(id: Int?, token: String?, completion: @escaping (Result<ResCounter?, Error>) -> ()) {
        APIInteractor.fetchProfileCounters(id: id, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // BUSCAR FOLLOWINGS.
    func fetchProfileFollowing(page: Int?, token: String?, completion: @escaping (Result<ResFollows?, Error>) -> ()) {
        APIInteractor.fetchProfileFollowing(page: page, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
    
    // BUSCAR FOLLOWRS.
    func fetchProfileFollowers(page: Int?, token: String?, completion: @escaping (Result<ResFollows?, Error>) -> ()) {
        APIInteractor.fetchProfileFollowers(page: page, token: token) { response in
            completion(.success(response))
        } processIncorrect: { messageError in
            completion(.failure(messageError as! Error))
        }
    }
}
