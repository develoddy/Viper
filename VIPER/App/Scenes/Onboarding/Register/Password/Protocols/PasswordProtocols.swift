import Foundation
import UIKit

protocol PasswordViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PasswordPresenterProtocol? { get set }
}

protocol PasswordWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createPasswordModule() -> UIViewController
    func navigatePicView(from view: PasswordViewProtocol)
}

protocol PasswordPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PasswordViewProtocol? { get set }
    var interactor: PasswordInteractorInputProtocol? { get set }
    var wireFrame: PasswordWireFrameProtocol? { get set }
    func viewDidLoad()
    func navigatePicView()
}

protocol PasswordInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol PasswordInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PasswordInteractorOutputProtocol? { get set }
    var localDatamanager: PasswordLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PasswordRemoteDataManagerInputProtocol? { get set }
}

protocol PasswordDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol PasswordRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PasswordRemoteDataManagerOutputProtocol? { get set }
}

protocol PasswordRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol PasswordLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
