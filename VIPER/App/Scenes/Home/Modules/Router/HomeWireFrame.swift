import Foundation
import UIKit

class HomeWireFrame: HomeWireFrameProtocol {
    
    class func createHomeModule() -> UIViewController {
        
        let homeView = HomeView()
        let viewController = homeView
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
        let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
        let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
        let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
        
        viewController.presenter                = presenter
        presenter.view                          = viewController
        presenter.wireFrame                     = wireFrame
        presenter.interactor                    = interactor
        interactor.presenter                    = presenter
        interactor.localDatamanager             = localDataManager
        interactor.remoteDatamanager            = remoteDataManager
        remoteDataManager.remoteRequestHandler  = interactor
        
        return viewController
    }
    
    // NAVIGATE GOTO PROFILE
    func navigateToProfile(from view: HomeViewProtocol, id: Int, name: String, token: String) {
        let newProfileView = ProfileWireFrame.createProfileModule(id: id, name: name, token: token, indexPath: [])
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newProfileView, animated: true)
        }
    }
    
    // NAVIGATE GOTO LIST COMMENTS
    func navigateToComments(from view: HomeViewProtocol, userpost: PostViewData) {
        let newListcommentsView = CommentsWireFrame.createCommentsModule(userpost: userpost)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newListcommentsView, animated: true)
        }
    }
    
    // NAVIGATE GOTO SHEET HOME POST VIEW.
    func navigateSheetHomePostsView(from view: HomeViewProtocol, post: PostViewData) {
        let newSheetHomePostsView = SheetHomePostsWireFrame.createSheetHomePostsModule(post: post)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.present(newSheetHomePostsView, animated: true, completion: nil)
        }
    }
}
