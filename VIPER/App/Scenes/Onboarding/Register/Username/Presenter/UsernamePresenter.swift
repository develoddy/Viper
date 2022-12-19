
import Foundation

class UsernamePresenter  {
    
    // MARK: Properties
    weak var view: UsernameViewProtocol?
    var interactor: UsernameInteractorInputProtocol?
    var wireFrame: UsernameWireFrameProtocol?
    
}

extension UsernamePresenter: UsernamePresenterProtocol {
    func viewDidLoad() {
    }
    
    func navigateToBirthdatView() {
        wireFrame?.navigateToBirthdatView(from: view!)
    }
}

extension UsernamePresenter: UsernameInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
