import Foundation
import UIKit

class WelcomeWireFrame: WelcomeWireFrameProtocol {
   
    class func createWelcomeModule() -> UIViewController {
        let welcomeView = WelcomeView()
        let viewController = welcomeView
        let presenter: WelcomePresenterProtocol & WelcomeInteractorOutputProtocol = WelcomePresenter()
        let interactor: WelcomeInteractorInputProtocol & WelcomeRemoteDataManagerOutputProtocol = WelcomeInteractor()
        let localDataManager: WelcomeLocalDataManagerInputProtocol = WelcomeLocalDataManager()
        let remoteDataManager: WelcomeRemoteDataManagerInputProtocol = WelcomeRemoteDataManager()
        let wireFrame: WelcomeWireFrameProtocol = WelcomeWireFrame()
        
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
    
    func navigateToLoginView(from view: WelcomeViewProtocol) {
        let newLoginView = LoginWireFrame.createLoginModule()
        
        if let sourceView = view as? UIViewController {
            let navigationController = UINavigationController( rootViewController: newLoginView )
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationItem.largeTitleDisplayMode = .never
            sourceView.present( navigationController, animated: true )
        }
    }
    
    func navigateToUsernameView(from view: WelcomeViewProtocol) {
        let newUsernameView = UsernameWireFrame.createUsernameModule()
        if let sourceView = view as? UIViewController {
            let navigationController = UINavigationController( rootViewController: newUsernameView )
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationItem.largeTitleDisplayMode = .never
            sourceView.present( navigationController, animated: true )
        }
    }
}
