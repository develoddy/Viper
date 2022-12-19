import Foundation
import UIKit

protocol SheeContactsChatViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SheeContactsChatPresenterProtocol? { get set }
    func updateUI()
    func startActivity()
    func stopActivity()
    func dismiss()
}

protocol SheeContactsChatWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSheeContactsChatModule() -> UIViewController
    func sendDataWithModuleEmail(from view: SheeContactsChatViewProtocol, username: String?, userId: Int?)
    func goToChatScreen(from view: UIViewController)
}

protocol SheeContactsChatPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SheeContactsChatViewProtocol? { get set }
    var interactor: SheeContactsChatInteractorInputProtocol? { get set }
    var wireFrame: SheeContactsChatWireFrameProtocol? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showData(indexPath: IndexPath) -> SheeContactsChatFormModel?
    func chooseOptions(indexPath: IndexPath, in viewController: UIViewController)
    func currentTopViewController() -> UIViewController
}

protocol SheeContactsChatInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( with viewModel: [[SheeContactsChatFormModel]] )
}

protocol SheeContactsChatInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SheeContactsChatInteractorOutputProtocol? { get set }
    var localDatamanager: SheeContactsChatLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SheeContactsChatRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
    func interactorGetFollows(token: String?)
}

protocol SheeContactsChatDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SheeContactsChatRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SheeContactsChatRemoteDataManagerOutputProtocol? { get set }
    func formGetData()
    func remoteGetFollows(token: String?)
}

protocol SheeContactsChatRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(section01: [SheeContactsChatFormModel], section02: [SheeContactsChatFormModel])
    func remoteCallBackFollows(section01: [SheeContactsChatFormModel], follows: [Follow])
}

protocol SheeContactsChatLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
