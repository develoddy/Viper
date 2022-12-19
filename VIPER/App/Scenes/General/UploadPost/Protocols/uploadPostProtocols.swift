import Foundation
import UIKit

protocol uploadPostViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: uploadPostPresenterProtocol? { get set }
}

protocol uploadPostWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createuploadPostModule() -> UIViewController
}

protocol uploadPostPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: uploadPostViewProtocol? { get set }
    var interactor: uploadPostInteractorInputProtocol? { get set }
    var wireFrame: uploadPostWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol uploadPostInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol uploadPostInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: uploadPostInteractorOutputProtocol? { get set }
    var localDatamanager: uploadPostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: uploadPostRemoteDataManagerInputProtocol? { get set }
}

protocol uploadPostDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol uploadPostRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: uploadPostRemoteDataManagerOutputProtocol? { get set }
}

protocol uploadPostRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol uploadPostLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
