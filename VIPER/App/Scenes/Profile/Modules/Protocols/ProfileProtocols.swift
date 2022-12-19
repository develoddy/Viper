import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    func updateUI()
    func startActivity()
    func stopActivity()
    func update()
    var page: Int! { get set }
}

protocol ProfileWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createProfileModule(id: Int, name:String, token:String, indexPath: IndexPath) -> UIViewController
    func gotoPostScreen(from view: ProfileViewProtocol, post: PostViewData?, indexPath: IndexPath)
    func navigateToEditProfile(from view: ProfileViewProtocol, model: UserViewData?)
    func gotoListPeopleScreen(following: [Follow], from view: ProfileViewProtocol, token: LoginToken?)
    func presentSheeMenu(from view: ProfileViewProtocol)
    func presentUploadPost(from view: ProfileViewProtocol)
}

protocol ProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    var page: Int? { get set }
    var idReceivedFromHome: Int? {get set}
    var nameReceivedFromHome: String? { get set }
    var tokenReceivedFromHome: String? { get set }
    var postReceivedFromSheetPost: Post? { get set }
    var indexPathReceivedFromSheePost: IndexPath? { get set }
    var isLoadingMore: Bool? { get set }
    func fetchPosts(page : Int)
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showPostsData(indexPath: IndexPath) -> PostViewData?
    func username() -> UserViewData?
    func tasts() -> ResCounter?
    func gotoPostScreen(post: PostViewData?, indexPath: IndexPath)
    func showFollowin() -> [Follow]
    func showFollowers() -> [Follow]
    func gotoEitProfileScreen(model: UserViewData?)
    func gotoListPeopleScreen(following: [Follow]?)
    func getPostCount() -> Int
    func getTotalPages() -> Int
    func gotoSheeMenu()
    func gotoUploadPost()
}

protocol ProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(id: Int, token: String)
    func interactorGetCounter(id: Int, token: String)
    func interactorGetPosts(id: Int, page: Int, token: String, isPagination:Bool)
    func interactorGetFollowing(page: Int, token: String)
    func interactorGetFollowers(page: Int, token: String)
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with viewModel: [User])
    func interactorCallBackTasts(with viewModel: [ResCounter])
    func interactorCallBackPosts(with viewModel: [Post], totalPages: Int)
    func interactorCallBackAppendPosts(with viewModel: [Post])
    func interactorCallBackFollowing(with viewModel: [Follow])
    func interactorCallBackFollowers(with viewModel: [Follow])
}

protocol ProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    var isPaginationOn: Bool? { get set }
    func remoteGetData(id: Int, token: String)
    func remoteGetCounter(id: Int, token: String)
    func remoteGetPosts(id: Int, page: Int, token: String, isPagination:Bool)
    func remoteGetFollowing(page: Int, token: String)
    func remoteGetFollowers(page: Int, token: String)
}

protocol ProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with viewModel: [User])
    func remoteCallBackTasts(with viewModel: [ResCounter])
    func remoteCallBackPosts(with viewModel: [Post], totalPages: Int)
    func remoteCallBackAppendPosts(with viewModel: [Post])
    func remoteCallBackFollowing(with viewModel: [Follow])
    func remoteCallBackFollowers(with viewModel: [Follow])
}

protocol ProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
