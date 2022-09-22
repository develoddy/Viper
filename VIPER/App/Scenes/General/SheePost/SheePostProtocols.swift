import Foundation
import UIKit

protocol SheePostViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SheePostPresenterProtocol? { get set }
    //func alertDelete()
    func dismiss()
}

protocol SheePostWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSheePostModule(post: Post?, indexPath: IndexPath) -> UIViewController
    func sendDataPost(from viewController: UIViewController, userId: Int, token: String, indexPath: IndexPath)
}

protocol SheePostPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SheePostViewProtocol? { get set }
    var interactor: SheePostInteractorInputProtocol? { get set }
    var wireFrame: SheePostWireFrameProtocol? { get set }
    var postReceivedFromPost: Post? { get set }
    var indexPathReceivedFromProfile: IndexPath? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showData(indexPath: IndexPath) -> SheePostFormModel?
    func getPost() -> Post?
    func choosePostOptions(indexPath: IndexPath, in viewController: UIViewController)
    func currentTopViewController() -> UIViewController
    func present(in viewController: UIViewController, indexPath: IndexPath)
}

protocol SheePostInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( with viewModel: [[SheePostFormModel]] )
    func interactorCallBackDeletePost(with delete: Bool)
    func interactorCallBackPosts(with viewModel: [Post])
}

protocol SheePostInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SheePostInteractorOutputProtocol? { get set }
    var localDatamanager: SheePostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SheePostRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
    func interactorDeletePost(post: Post?, token: String)
    
    func interactorGetPosts(id: Int, page: Int, token: String) 
}

protocol SheePostDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SheePostRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SheePostRemoteDataManagerOutputProtocol? { get set }
    func formGetData()
    func remoteGetPosts(id: Int, page: Int, token: String)
    func remoteDeletePost(post: Post?, token: String)
}

protocol SheePostRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(section01: [SheePostFormModel], section02: [SheePostFormModel])
    func remoteCallBackDeletePost(with delete: Bool)
    func remoteCallBackPosts(with viewModel: [Post])
}

protocol SheePostLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
