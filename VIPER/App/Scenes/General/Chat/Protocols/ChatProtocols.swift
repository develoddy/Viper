import Foundation
import UIKit

protocol ChatViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ChatPresenterProtocol? { get set }
}

protocol ChatWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createChatModule(userId: Int?, username: String?) -> UIViewController
}

protocol ChatPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ChatViewProtocol? { get set }
    var interactor: ChatInteractorInputProtocol? { get set }
    var wireFrame: ChatWireFrameProtocol? { get set }
    var receiveDataFollowId: Int? { get set }
    var receiveDataFollowUsername: String? { get set }
    func viewDidLoad()
}

protocol ChatInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol ChatInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ChatInteractorOutputProtocol? { get set }
    var localDatamanager: ChatLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ChatRemoteDataManagerInputProtocol? { get set }
}

protocol ChatDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ChatRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ChatRemoteDataManagerOutputProtocol? { get set }
}

protocol ChatRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ChatLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
