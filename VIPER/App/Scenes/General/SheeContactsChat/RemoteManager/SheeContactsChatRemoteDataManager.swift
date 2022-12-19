import Foundation

class SheeContactsChatRemoteDataManager:SheeContactsChatRemoteDataManagerInputProtocol {

    var remoteRequestHandler: SheeContactsChatRemoteDataManagerOutputProtocol?
    let apiManager: ProAPIManagerProtocol
    
    // MARK:  CONSTRUCTOR
    init(apiManager: ProAPIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func formGetData() {
        /*let section01: [SheeContactsChatFormModel] = [
            SheeContactsChatFormModel(iconImage: "person.3.fill", label: "Nuevo grupo"),
            SheeContactsChatFormModel(iconImage: "person.badge.plus", label: "Nuevo contacto")]
        
        let section02: [SheeContactsChatFormModel] = [
            SheeContactsChatFormModel(iconImage: "person.circle.fill", label: "Name")]
        remoteRequestHandler?.remoteCallBackData(section01: section01, section02: section02)*/
    }
    
    func remoteGetFollows(token: String?) {
        apiManager.fetchUsers(token: token) { [weak self] result in
            switch result {
            case .success(let response):
                let section01: [SheeContactsChatFormModel] = [
                    SheeContactsChatFormModel(iconImage: "person.3.fill", label: "Nuevo grupo", userId: 0),
                    SheeContactsChatFormModel(iconImage: "person.badge.plus", label: "Nuevo contacto", userId: 0)]
                
                // GET FOLLOWS
                if let follows = response?.follows {
                    // LLAMAR AL INTERACTOR
                    self?.remoteRequestHandler?.remoteCallBackFollows(section01: section01, follows: follows)
                }
            case .failure(let error): print("Remote: Error processing profile like\(error)")
            }
        }
    }
}
