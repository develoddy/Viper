import Foundation
import UIKit

protocol WelcomeViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: WelcomePresenterProtocol? { get set }
}

protocol WelcomeWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createWelcomeModule() -> UIViewController
    func navigateToLoginView(from view: WelcomeViewProtocol)
    func navigateToUsernameView(from view: WelcomeViewProtocol)
}

protocol WelcomePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: WelcomeViewProtocol? { get set }
    var interactor: WelcomeInteractorInputProtocol? { get set }
    var wireFrame: WelcomeWireFrameProtocol? { get set }
    func viewDidLoad()
    func navigateToLoginView()
    func navigateToUsernameView()
}

protocol WelcomeInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol WelcomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: WelcomeInteractorOutputProtocol? { get set }
    var localDatamanager: WelcomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: WelcomeRemoteDataManagerInputProtocol? { get set }
}

protocol WelcomeDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol WelcomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: WelcomeRemoteDataManagerOutputProtocol? { get set }
}

protocol WelcomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol WelcomeLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
