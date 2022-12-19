import Foundation
import UIKit

class EmailWireFrame: EmailWireFrameProtocol {
  
    class func createEmailModule() -> UIViewController {
        let emailView = EmailView()
        let viewController = emailView
        
        let presenter: EmailPresenterProtocol & EmailInteractorOutputProtocol = EmailPresenter()
        let interactor: EmailInteractorInputProtocol & EmailRemoteDataManagerOutputProtocol = EmailInteractor()
        let localDataManager: EmailLocalDataManagerInputProtocol = EmailLocalDataManager()
        let remoteDataManager: EmailRemoteDataManagerInputProtocol = EmailRemoteDataManager()
        let wireFrame: EmailWireFrameProtocol = EmailWireFrame()
        
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
    
    func navigateChat(from view: UIViewController?) {
        let newChatView = ChatWireFrame.createChatModule(userId: 0, username: "")
        view?.navigationController?.pushViewController(newChatView, animated: true)
    }
    
    // NAVIGATION TO OTHER MODULE
    // NAVAGATION TO CHAT SCREEN
    func navigateToChat(from view: EmailViewProtocol) {
        // NAVEGAR A OTRO NODULO (CHAT)
        let newChatView = ChatWireFrame.createChatModule(userId: 0, username: "")
        if let sourceView = view as? UIViewController {
            //let navigationController = UINavigationController(rootViewController: newChatView )
            //navigationController.modalPresentationStyle = .fullScreen
            sourceView.navigationController?.pushViewController(newChatView, animated: true)
            //sourceView.present( navigationController, animated: true, completion: nil )
            
        }
    }
    
    func navigateToSheeContactsChat(from view: EmailViewProtocol) {
        let newMessage = NewMessageWireFrame.createNewMessageModule() //SheeContactsChatWireFrame.createSheeContactsChatModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newMessage, animated: true)
        }
    }
}
