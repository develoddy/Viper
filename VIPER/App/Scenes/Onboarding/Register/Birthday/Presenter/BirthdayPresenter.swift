import Foundation

class BirthdayPresenter  {
    
    // MARK: Properties
    weak var view: BirthdayViewProtocol?
    var interactor: BirthdayInteractorInputProtocol?
    var wireFrame: BirthdayWireFrameProtocol?
    
}

extension BirthdayPresenter: BirthdayPresenterProtocol {
  
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func navigateToPasswordView() {
        // LLAMAR AL WIREFRAME
        wireFrame?.navigateToPasswordView(from: view!)
    }
    
}

extension BirthdayPresenter: BirthdayInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
