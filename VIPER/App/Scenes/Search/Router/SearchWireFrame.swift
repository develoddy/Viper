import Foundation
import UIKit

class SearchWireFrame: SearchWireFrameProtocol {
    
    class func createSearchModule() -> UIViewController {
        
        let searchView = SearchView()
        let viewController = searchView
        let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
        let interactor: SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchInteractor()
        let localDataManager: SearchLocalDataManagerInputProtocol = SearchLocalDataManager()
        let remoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager()
        let wireFrame: SearchWireFrameProtocol = SearchWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
    // LLAMAR AL MODULO (SEARCH RESULT)
    func gotoSearchResultsUpdating(from view: SearchViewProtocol, resultsComtroller: SearchResultView, filter: String) {
        resultsComtroller.presenter?.filter = filter
        resultsComtroller.presenter?.viewDidLoad()
    }
    
    // LLAMAR AL MODULO POST
    func navigateToPost(from view: SearchViewProtocol, post: PostViewData? /*Post?*/) {
        guard let post = post else {
            return
        }
        
        let newPostView = PostWireFrame.createPostModule(post: post, indexPath: [0,0])
        if let sourceView = view as? UIViewController {
            newPostView.title = "Explorar"
            //sourceView.navigationController?.pushViewController(newPostView, animated: true)
            let navigationController = UINavigationController(rootViewController: newPostView )
            navigationController.modalPresentationStyle = .fullScreen
            sourceView.present( navigationController, animated: true )
        }
    }
}
