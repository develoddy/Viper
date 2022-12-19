import UIKit

class SheeContactsChatPresenter  {
    
    // MARK: Properties
    weak var view: SheeContactsChatViewProtocol?
    var interactor: SheeContactsChatInteractorInputProtocol?
    var wireFrame: SheeContactsChatWireFrameProtocol?
    var token = Token()
    
    // MARK: CLOSURES
    //private var viewModel = [ [ SheeContactsChatFormModel ] ]()
    var viewModel: [ [ SheeContactsChatFormModel ] ]  = [] {
        didSet {
            self.view?.updateUI()
        }
    }
}

extension SheeContactsChatPresenter: SheeContactsChatPresenterProtocol {

    func viewDidLoad() {
        interactor?.interactorGetFollows(token: token.getUserToken().success)
    }
    
    func presenterNumberOfSections() -> Int {
        return self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        return self.viewModel[section].count
    }
    
    func showData(indexPath: IndexPath) -> SheeContactsChatFormModel? {
        return self.viewModel[indexPath.section][indexPath.row]
    }
    
    func currentTopViewController() -> UIViewController {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        var topVC: UIViewController? = keyWindow?.rootViewController
        topVC = topVC?.presentedViewController
        return topVC!
    }
    
    func chooseOptions(indexPath: IndexPath, in viewController: UIViewController) {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            let data = self.viewModel[indexPath.section][indexPath.row]
            //let currentTopVC: UIViewController? = self.currentTopViewController()
            //wireFrame?.goToChatScreen(from: currentTopVC!)
            wireFrame?.sendDataWithModuleEmail(from: self.view!, username: data.label, userId: data.userId)
        }
    }
}

extension SheeContactsChatPresenter: SheeContactsChatInteractorOutputProtocol {
    
    func interactorCallBackData(with viewModel: [[SheeContactsChatFormModel]]) {
        self.viewModel = viewModel
    }
}
