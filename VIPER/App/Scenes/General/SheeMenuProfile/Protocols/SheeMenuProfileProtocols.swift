import UIKit

protocol SheeMenuProfileViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SheeMenuProfilePresenterProtocol? { get set }
}

protocol SheeMenuProfileWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSheeMenuProfileModule() -> UIViewController
    func gotoLoginView(from view: SheeMenuProfileViewProtocol)
}

protocol SheeMenuProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SheeMenuProfileViewProtocol? { get set }
    var interactor: SheeMenuProfileInteractorInputProtocol? { get set }
    var wireFrame: SheeMenuProfileWireFrameProtocol? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showData(indexPath: IndexPath) -> SheeMenuFormModel?
    func chooseOptions(indexPath: IndexPath, in viewController: UIViewController)
}

protocol SheeMenuProfileInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( with viewModel: [[SheeMenuFormModel]] )
}

protocol SheeMenuProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SheeMenuProfileInteractorOutputProtocol? { get set }
    var localDatamanager: SheeMenuProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SheeMenuProfileRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
}

protocol SheeMenuProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SheeMenuProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SheeMenuProfileRemoteDataManagerOutputProtocol? { get set }
    func formGetData()
}

protocol SheeMenuProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(section01: [SheeMenuFormModel], section02: [SheeMenuFormModel])
}

protocol SheeMenuProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
