import Foundation

class SheetHomePostsInteractor: SheetHomePostsInteractorInputProtocol {
   
    // MARK: PROPERTIES
    weak var presenter: SheetHomePostsInteractorOutputProtocol?
    var localDatamanager: SheetHomePostsLocalDataManagerInputProtocol?
    var remoteDatamanager: SheetHomePostsRemoteDataManagerInputProtocol?
    
    // MARK: CLOSURES
    var section01 = [SheeHomePostsFormModel]()
    var section02 = [SheeHomePostsFormModel]()
    private var viewModel = [ [ SheeHomePostsFormModel ] ]()
    
    func interactorGetData() {
        self.remoteDatamanager?.formGetData()
    }
}

extension SheetHomePostsInteractor: SheetHomePostsRemoteDataManagerOutputProtocol {
    
    /* ------------ LLAMAR AL PRESENTER -------------
     * EN ESTE PUNTO EL INTERACTOR HA RECIBIDO DATOS DE LA CAPA EXTERNALDATAMANAGER,
     * Y TENDREMOS QUE PASARLE A LA CAPA DEL PRESENTER.
     */
    func remoteCallBackData(section01: Set<SheeHomePostsFormModel>, section02: Set<SheeHomePostsFormModel>) {
        // SECTION 01
        for item in section01 {
            let model = SheeHomePostsFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section01.append(model)
        }
        self.viewModel.append(self.section01)

        // SECTION 02
        for item in section02 {
            let model = SheeHomePostsFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section02.append(model)
        }
        self.viewModel.append(self.section02)
        
        // LLAMAR AL PRESENTER.
        self.presenter?.interactorCallBackData(with: self.viewModel)
    }
}
