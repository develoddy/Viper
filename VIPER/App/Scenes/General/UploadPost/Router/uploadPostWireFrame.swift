import Foundation
import UIKit

class uploadPostWireFrame: uploadPostWireFrameProtocol {

    class func createuploadPostModule() -> UIViewController {
        let uploadPostView = uploadPostView()
        let viewController = uploadPostView
        let presenter: uploadPostPresenterProtocol & uploadPostInteractorOutputProtocol = uploadPostPresenter()
        let interactor: uploadPostInteractorInputProtocol & uploadPostRemoteDataManagerOutputProtocol = uploadPostInteractor()
        let localDataManager: uploadPostLocalDataManagerInputProtocol = uploadPostLocalDataManager()
        let remoteDataManager: uploadPostRemoteDataManagerInputProtocol = uploadPostRemoteDataManager()
        let wireFrame: uploadPostWireFrameProtocol = uploadPostWireFrame()
        
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
}
