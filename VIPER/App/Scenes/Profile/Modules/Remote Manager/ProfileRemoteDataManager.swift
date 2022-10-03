import Foundation

// MARK: REMOTE DATA MANAGER
class ProfileRemoteDataManager:ProfileRemoteDataManagerInputProtocol {
    
    // MARK: PROPERTIES
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    var isPaginationOn: Bool? = false
    var viewModelPost: [Post] = []
    var viewModel: [User] = []
    var viewModelTasts: [ResCounter] = []
    
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    // PROFILE.
    func remoteGetData(id: Int, token: String) {
        self.apiManager.fetchProfile(id: id, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let user = response?.user {
                    self?.viewModel.append(user)
                    self?.remoteRequestHandler?.remoteCallBackData(with: self?.viewModel ?? [])
                }
            case .failure(let error): print("Remote: Error processing profile like\(error)")
            }
        }
    }
    
    
    // TASKS.
    func remoteGetCounter(id: Int, token: String) {
        self.apiManager.fetchProfileCounters(id: id, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let tasks = response {
                    self?.viewModelTasts.append(tasks)
                    self?.remoteRequestHandler?.remoteCallBackTasts(with: self?.viewModelTasts ?? [])
                }
            case .failure(let error): print("Remote: Error processing profile counter\(error)")
            }
        }
    }
    
    
    // POSTS.
    func remoteGetPosts(id: Int, page: Int, token: String, isPagination:Bool) {
        self.apiManager.fetchProfilePosts(id: id, page: page, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let posts = response?.resPostImages?.posts, let totalPages = response?.resPostImages?.totalPages {
                    if isPagination {
                        self?.remoteRequestHandler?.remoteCallBackAppendPosts(with: posts)
                        if isPagination {
                            self?.isPaginationOn = false
                        }
                    } else {
                        self?.remoteRequestHandler?.remoteCallBackPosts( with: posts, totalPages: totalPages )
                        if isPagination {
                            self?.isPaginationOn = false
                        }
                    }
                }
            case .failure(let error): print("Error processing profile posts.\(error)")
            }
        }
    }
    
    
    // FOLLOWING.
    func remoteGetFollowing(page: Int, token: String) {
        self.apiManager.fetchProfileFollowing(page: page, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let following = response?.follows {
                    self?.remoteRequestHandler?.remoteCallBackFollowing(with: following)
                }
            case .failure(let error): print("Error processing profile following.\(error)")
            }
        }
    }
    
    // FOLLOWERS.
    func remoteGetFollowers(page: Int, token: String) {
        self.apiManager.fetchProfileFollowers(page: page, token: token) { [weak self] result in
            switch result {
            case .success(let response):
                if let following = response?.follows {
                    self?.remoteRequestHandler?.remoteCallBackFollowers(with: following)
                }
            case .failure(let error): print("Error processing profile following.\(error)")
            }
        }
    }
}
