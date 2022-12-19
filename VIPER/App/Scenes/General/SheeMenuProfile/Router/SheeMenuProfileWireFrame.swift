import Foundation
import UIKit

class SheeMenuProfileWireFrame: SheeMenuProfileWireFrameProtocol {
    
    class func createSheeMenuProfileModule() -> UIViewController {
        let sheeMenu = SheeMenuProfileView()
        let viewController = sheeMenu
        let presenter: SheeMenuProfilePresenterProtocol & SheeMenuProfileInteractorOutputProtocol = SheeMenuProfilePresenter()
        let interactor: SheeMenuProfileInteractorInputProtocol & SheeMenuProfileRemoteDataManagerOutputProtocol = SheeMenuProfileInteractor()
        let localDataManager: SheeMenuProfileLocalDataManagerInputProtocol = SheeMenuProfileLocalDataManager()
        let remoteDataManager: SheeMenuProfileRemoteDataManagerInputProtocol = SheeMenuProfileRemoteDataManager()
        let wireFrame: SheeMenuProfileWireFrameProtocol = SheeMenuProfileWireFrame()
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
    
    func gotoLoginView(from view: SheeMenuProfileViewProtocol) {
        let newLoginView = LoginWireFrame.createLoginModule()
        if let sourceView = view as? UIViewController {
            let navigationController = UINavigationController( rootViewController: newLoginView )
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationItem.largeTitleDisplayMode = .never
            sourceView.present( navigationController, animated: true )
            // sourceView.present( UINavigationController( rootViewController: newEditProfileView ), animated: true )
        }
    }
}
