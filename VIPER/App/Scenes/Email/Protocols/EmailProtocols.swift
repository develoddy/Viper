import Foundation
import UIKit

protocol EmailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: EmailPresenterProtocol? { get set }
    func updateUIList()
    func startActivity()
    func stopActivity()
    func setDataFollows(username: String?, userId: Int?)
}

protocol EmailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createEmailModule() -> UIViewController
    func navigateToChat(from view: EmailViewProtocol)
    func navigateToSheeContactsChat(from view: EmailViewProtocol)
    func navigateChat(from view: UIViewController?)
}

protocol EmailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: EmailViewProtocol? { get set }
    var interactor: EmailInteractorInputProtocol? { get set }
    var wireFrame: EmailWireFrameProtocol? { get set }
    func viewDidLoad()
    //func currentTopViewController() -> UIViewController
    func getDaataFollows(username: String?, userId: Int?)
    func goToChatScreen()
    func goToSheeContactsChatScreen()
    
}

protocol EmailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol EmailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: EmailInteractorOutputProtocol? { get set }
    var localDatamanager: EmailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: EmailRemoteDataManagerInputProtocol? { get set }
}

protocol EmailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol EmailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: EmailRemoteDataManagerOutputProtocol? { get set }
}

protocol EmailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol EmailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
