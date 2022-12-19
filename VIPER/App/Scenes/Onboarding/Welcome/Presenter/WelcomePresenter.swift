import Foundation

class WelcomePresenter  {
    
    // MARK: Properties
    weak var view: WelcomeViewProtocol?
    var interactor: WelcomeInteractorInputProtocol?
    var wireFrame: WelcomeWireFrameProtocol?
}

extension WelcomePresenter: WelcomePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func navigateToLoginView() {
        wireFrame?.navigateToLoginView(from: view!)
    }
    
    func navigateToUsernameView() {
        wireFrame?.navigateToUsernameView(from: view!)
    }
}

extension WelcomePresenter: WelcomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
