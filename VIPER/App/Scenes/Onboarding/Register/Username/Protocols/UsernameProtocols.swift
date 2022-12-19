import Foundation
import UIKit

protocol UsernameViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: UsernamePresenterProtocol? { get set }
}

protocol UsernameWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createUsernameModule() -> UIViewController
    func navigateToBirthdatView(from view: UsernameViewProtocol)
}

protocol UsernamePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: UsernameViewProtocol? { get set }
    var interactor: UsernameInteractorInputProtocol? { get set }
    var wireFrame: UsernameWireFrameProtocol? { get set }
    func viewDidLoad()
    func navigateToBirthdatView()
}

protocol UsernameInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol UsernameInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: UsernameInteractorOutputProtocol? { get set }
    var localDatamanager: UsernameLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: UsernameRemoteDataManagerInputProtocol? { get set }
}

protocol UsernameDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol UsernameRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: UsernameRemoteDataManagerOutputProtocol? { get set }
}

protocol UsernameRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol UsernameLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
