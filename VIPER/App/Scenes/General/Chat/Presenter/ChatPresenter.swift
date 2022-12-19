import Foundation

class ChatPresenter: ChatPresenterProtocol  {
    
    // MARK: Properties
    weak var view: ChatViewProtocol?
    var interactor: ChatInteractorInputProtocol?
    var wireFrame: ChatWireFrameProtocol?
    var receiveDataFollowId: Int?
    var receiveDataFollowUsername: String?

    func viewDidLoad() {
        //print("ChatPresenter - setDataFollows")
        //print(receiveDataFollowUsername)
    }
}

extension ChatPresenter: ChatInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
