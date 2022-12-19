import Foundation
import UIKit

class ChatWireFrame: ChatWireFrameProtocol {

    class func createChatModule(userId: Int?, username: String?) -> UIViewController {
        let viewController = ChatView()
        let presenter: ChatPresenterProtocol & ChatInteractorOutputProtocol = ChatPresenter()
        let interactor: ChatInteractorInputProtocol & ChatRemoteDataManagerOutputProtocol = ChatInteractor()
        let localDataManager: ChatLocalDataManagerInputProtocol = ChatLocalDataManager()
        let remoteDataManager: ChatRemoteDataManagerInputProtocol = ChatRemoteDataManager()
        let wireFrame: ChatWireFrameProtocol = ChatWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        presenter.receiveDataFollowId = userId
        presenter.receiveDataFollowUsername = username
        
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
}
