
import Foundation
import UIKit

class NewMessageWireFrame: NewMessageWireFrameProtocol {

    class func createNewMessageModule() -> UIViewController {
        
        let viewController = NewMessageView()
        let presenter: NewMessagePresenterProtocol & NewMessageInteractorOutputProtocol = NewMessagePresenter()
        let interactor: NewMessageInteractorInputProtocol & NewMessageRemoteDataManagerOutputProtocol = NewMessageInteractor()
        let localDataManager: NewMessageLocalDataManagerInputProtocol = NewMessageLocalDataManager()
        let remoteDataManager: NewMessageRemoteDataManagerInputProtocol = NewMessageRemoteDataManager()
        let wireFrame: NewMessageWireFrameProtocol = NewMessageWireFrame()
        
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
    
    func navigateToChat(from view: NewMessageViewProtocol) {
        let newChatView = ChatWireFrame.createChatModule(userId: 0, username: "")
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newChatView, animated: true)
        }
    }
}
