import UIKit

class EmailPresenter: EmailPresenterProtocol   {
   
    // MARK: Properties
    weak var view: EmailViewProtocol?
    var interactor: EmailInteractorInputProtocol?
    var wireFrame: EmailWireFrameProtocol?
    var receiveDataFollowId: Int?
    var receiveDataFollowUsername: String?
    

    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    /*func currentTopViewController() -> UIViewController {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        var topVC: UIViewController? = keyWindow?.rootViewController
        topVC = topVC?.presentedViewController
        return topVC!
    }*/
    
    func getDaataFollows(username: String?, userId: Int?) {
        print("Email Presenter - getDaataFollows: ")
        
        /*guard let username = username, let userId = userId else {
            return
        }
        print(username)
        print(userId)*/
        
        //let currentTopVC: UIViewController? = self.currentTopViewController()
        //wireFrame?.navigateChat(from: currentTopVC)
    }

    // LLAMAR AL WIREFRAME O ROUTER
    func goToChatScreen() {
        wireFrame?.navigateToChat(from: self.view!)
    }
    
    func goToSheeContactsChatScreen() {
        wireFrame?.navigateToSheeContactsChat(from: view!)
    }
    
}

extension EmailPresenter: EmailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
