import Foundation
import UIKit

class PicWireFrame: PicWireFrameProtocol {
    class func createPicModule() -> UIViewController {
        let view = PicView()
        let presenter: PicPresenterProtocol & PicInteractorOutputProtocol = PicPresenter()
        let interactor: PicInteractorInputProtocol & PicRemoteDataManagerOutputProtocol = PicInteractor()
        let localDataManager: PicLocalDataManagerInputProtocol = PicLocalDataManager()
        let remoteDataManager: PicRemoteDataManagerInputProtocol = PicRemoteDataManager()
        let wireFrame: PicWireFrameProtocol = PicWireFrame()
        
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
}
