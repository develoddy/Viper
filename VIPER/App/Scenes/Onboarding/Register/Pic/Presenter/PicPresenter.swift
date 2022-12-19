import Foundation

class PicPresenter  {
    
    // MARK: Properties
    weak var view: PicViewProtocol?
    var interactor: PicInteractorInputProtocol?
    var wireFrame: PicWireFrameProtocol?
    
}

extension PicPresenter: PicPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension PicPresenter: PicInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
