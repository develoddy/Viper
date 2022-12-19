import Foundation

class NewMessageInteractor: NewMessageInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: NewMessageInteractorOutputProtocol?
    var localDatamanager: NewMessageLocalDataManagerInputProtocol?
    var remoteDatamanager: NewMessageRemoteDataManagerInputProtocol?
    
    func interactorGetFollows(token: String?) {
        remoteDatamanager?.remoteGetFollows(token: token)
    }
}

extension NewMessageInteractor: NewMessageRemoteDataManagerOutputProtocol {
    func remoteCallBackFollows(follows: [Follow]) {
        presenter?.interactorCallBackData(follows: follows)
    }
}
