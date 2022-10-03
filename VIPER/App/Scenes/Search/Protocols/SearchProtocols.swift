import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchPresenterProtocol? { get set }
    var page: Int! { get set }
    var totalPages:Int! { get set }
    var postsQuantity:Int! { get set }
    func updateUI()
    func startActivity()
    func stopActivity()
    func postsCount(count: Int, totalPages: Int)
}

protocol SearchWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSearchModule() -> UIViewController
    func gotoSearchResultsUpdating(from view: SearchViewProtocol, resultsComtroller: SearchResultView, filter: String)
    func navigateToPost(from view: SearchViewProtocol, post: PostViewData? /*Post?*/)
}

protocol SearchPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireFrame: SearchWireFrameProtocol? { get set }
    
    var page: Int? { get set }
    func getTotalPages() -> Int
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showUserpostData(indexPath: IndexPath) -> PostViewData //Post
    func searchResultsUpdating(resultsComtroller: SearchResultView, filter: String)
    func gotoPostScreen(post: PostViewData? /*Post?*/)
    func loadMoreData(page: Int)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(userpost: [Post], totalPages: Int)
    func interactorCallBackDataAppend(userpost: [Post])
}

protocol SearchInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(page: Int, isPagination:Bool, token: String)
}

protocol SearchDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var isPaginationOn: Bool? { get set }
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData(page: Int, isPagination:Bool, token: String)
}

protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(userpost: [Post], totalPages: Int)
    func remoteCallBackDataAppend(userpost: [Post])
}

protocol SearchLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
