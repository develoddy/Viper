import Foundation
import UIKit

class PasswordWireFrame: PasswordWireFrameProtocol {

    class func createPasswordModule() -> UIViewController {
        let view = PasswordView()
        let presenter: PasswordPresenterProtocol & PasswordInteractorOutputProtocol = PasswordPresenter()
        let interactor: PasswordInteractorInputProtocol & PasswordRemoteDataManagerOutputProtocol = PasswordInteractor()
        let localDataManager: PasswordLocalDataManagerInputProtocol = PasswordLocalDataManager()
        let remoteDataManager: PasswordRemoteDataManagerInputProtocol = PasswordRemoteDataManager()
        let wireFrame: PasswordWireFrameProtocol = PasswordWireFrame()
        
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
    
    func navigatePicView(from view: PasswordViewProtocol) {
        let newPicView = PicWireFrame.createPicModule() 
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newPicView, animated: true)
        }
    }
    
}
