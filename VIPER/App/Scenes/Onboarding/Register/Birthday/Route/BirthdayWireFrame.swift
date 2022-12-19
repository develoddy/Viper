
import Foundation
import UIKit

class BirthdayWireFrame: BirthdayWireFrameProtocol {
  
    class func createBirthdayModule() -> UIViewController {
        let view = BirthdayView()
        let presenter: BirthdayPresenterProtocol & BirthdayInteractorOutputProtocol = BirthdayPresenter()
        let interactor: BirthdayInteractorInputProtocol & BirthdayRemoteDataManagerOutputProtocol = BirthdayInteractor()
        let localDataManager: BirthdayLocalDataManagerInputProtocol = BirthdayLocalDataManager()
        let remoteDataManager: BirthdayRemoteDataManagerInputProtocol = BirthdayRemoteDataManager()
        let wireFrame: BirthdayWireFrameProtocol = BirthdayWireFrame()
        
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
    
    func navigateToPasswordView(from view: BirthdayViewProtocol) {
        let newPasswordView = PasswordWireFrame.createPasswordModule() 
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newPasswordView, animated: true)
        }
    }
    
    
}
