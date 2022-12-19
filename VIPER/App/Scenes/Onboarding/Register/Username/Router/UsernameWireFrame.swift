import Foundation
import UIKit

class UsernameWireFrame: UsernameWireFrameProtocol {
    class func createUsernameModule() -> UIViewController {
        let view = UsernameView()
        let presenter: UsernamePresenterProtocol & UsernameInteractorOutputProtocol = UsernamePresenter()
        let interactor: UsernameInteractorInputProtocol & UsernameRemoteDataManagerOutputProtocol = UsernameInteractor()
        let localDataManager: UsernameLocalDataManagerInputProtocol = UsernameLocalDataManager()
        let remoteDataManager: UsernameRemoteDataManagerInputProtocol = UsernameRemoteDataManager()
        let wireFrame: UsernameWireFrameProtocol = UsernameWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
    
    func navigateToBirthdatView(from view: UsernameViewProtocol) {
        let newBirthdayView = BirthdayWireFrame.createBirthdayModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newBirthdayView, animated: true)
        }
    }
}
