
import Foundation
import UIKit

class SheeContactsChatWireFrame: SheeContactsChatWireFrameProtocol {
   
    
    class func createSheeContactsChatModule() -> UIViewController {
        
        let viewController = SheeContactsChatView()
        let presenter: SheeContactsChatPresenterProtocol & SheeContactsChatInteractorOutputProtocol = SheeContactsChatPresenter()
        let interactor: SheeContactsChatInteractorInputProtocol & SheeContactsChatRemoteDataManagerOutputProtocol = SheeContactsChatInteractor()
        let localDataManager: SheeContactsChatLocalDataManagerInputProtocol = SheeContactsChatLocalDataManager()
        let remoteDataManager: SheeContactsChatRemoteDataManagerInputProtocol = SheeContactsChatRemoteDataManager()
        let wireFrame: SheeContactsChatWireFrameProtocol = SheeContactsChatWireFrame()
        
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

    func sendDataWithModuleEmail(from view: SheeContactsChatViewProtocol, username: String?, userId: Int?) {
        let vc : EmailView = EmailWireFrame.createEmailModule() as! EmailView
        //let vc = EmailWireFrame.createEmailModule()
        if let sourceView = view as? UIViewController {
            /*sourceView.navigationController?.popViewController(animated: true)
            sourceView.dismiss(animated: true, completion: {
                vc.setDataFollows(username: username, userId: userId)
            })*/
            
            let navigationController = UINavigationController(rootViewController: vc )
            navigationController.modalPresentationStyle = .fullScreen
            sourceView.present(navigationController, animated: true)
            
            /*sourceView.dismiss(animated: true, completion: {
                vc.setDataFollows(username: username, userId: userId)
            })*/
        }
        
    }
    
    
    func goToChatScreen(from view: UIViewController) {
        let vc : EmailView = EmailWireFrame.createEmailModule() as! EmailView
        
        view.navigationController?.popViewController(animated: true)
        view.dismiss(animated: true, completion: {
            vc.setDataFollows(username: "", userId: 0)
        })
        
    }
}
