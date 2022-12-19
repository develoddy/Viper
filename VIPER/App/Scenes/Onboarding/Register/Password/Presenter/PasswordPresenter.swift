import Foundation

class PasswordPresenter  {
    
    // MARK: Properties
    weak var view: PasswordViewProtocol?
    var interactor: PasswordInteractorInputProtocol?
    var wireFrame: PasswordWireFrameProtocol?
    
}

extension PasswordPresenter: PasswordPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func navigatePicView() {
        wireFrame?.navigatePicView(from: view!)
    }
    
}

extension PasswordPresenter: PasswordInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
