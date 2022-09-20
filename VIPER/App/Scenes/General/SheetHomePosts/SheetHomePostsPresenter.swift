import Foundation

class SheetHomePostsPresenter  {
    
    // MARK: PROPERTIES
    weak var view: SheetHomePostsViewProtocol?
    var interactor: SheetHomePostsInteractorInputProtocol?
    var wireFrame: SheetHomePostsWireFrameProtocol?
    var postReceivedFromHome: Post?
    
    // MARK: CLOSURES
    private var viewModel = [ [ SheeHomePostsFormModel ] ]()
}

extension SheetHomePostsPresenter: SheetHomePostsPresenterProtocol {

    // TODO: IMPLEMENT PRESENTER METHODS
    func viewDidLoad() {
        // LLAMAR AL INTERACTOR
        // NOS LLEGA DESDE EL HOME DATOS EN "postReceivedFromHome"
        self.interactor?.interactorGetData()
    }
    
    func presenterNumberOfSections() -> Int {
        return self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        return self.viewModel[section].count
    }
    
    func showData(indexPath: IndexPath) -> SheeHomePostsFormModel? {
        return self.viewModel[indexPath.section][indexPath.row]
    }
    
    func getPost() -> Post? {
        return self.postReceivedFromHome
    }
    
    // ENVIAR POST AL HOMEVIEW.
    func postSentHome() {
        //print(self.postReceivedFromHome)
    }
}


extension SheetHomePostsPresenter: SheetHomePostsInteractorOutputProtocol {
    
    // TODO: IMPLEMENT INTERACTOS OUTPUT METHODS
    func interactorCallBackData(with viewModel: [[SheeHomePostsFormModel]]) {
        self.viewModel = viewModel
    }
}
