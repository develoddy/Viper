import Foundation

class uploadPostPresenter  {
    
    // MARK: PROPERTIES
    weak var view: uploadPostViewProtocol?
    var interactor: uploadPostInteractorInputProtocol?
    var wireFrame: uploadPostWireFrameProtocol?
}

//
extension uploadPostPresenter: uploadPostPresenterProtocol {
    func viewDidLoad() {
    }
}

extension uploadPostPresenter: uploadPostInteractorOutputProtocol {
}
