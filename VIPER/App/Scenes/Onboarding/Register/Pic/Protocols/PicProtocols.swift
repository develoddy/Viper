import Foundation
import UIKit

protocol PicViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PicPresenterProtocol? { get set }
}

protocol PicWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createPicModule() -> UIViewController
}

protocol PicPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PicViewProtocol? { get set }
    var interactor: PicInteractorInputProtocol? { get set }
    var wireFrame: PicWireFrameProtocol? { get set }
    func viewDidLoad()
}

protocol PicInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol PicInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PicInteractorOutputProtocol? { get set }
    var localDatamanager: PicLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PicRemoteDataManagerInputProtocol? { get set }
}

protocol PicDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol PicRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PicRemoteDataManagerOutputProtocol? { get set }
}

protocol PicRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol PicLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
