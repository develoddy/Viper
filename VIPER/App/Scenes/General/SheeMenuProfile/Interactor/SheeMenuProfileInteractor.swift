import Foundation

class SheeMenuProfileInteractor: SheeMenuProfileInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: SheeMenuProfileInteractorOutputProtocol?
    var localDatamanager: SheeMenuProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: SheeMenuProfileRemoteDataManagerInputProtocol?
    
    // MARK: CLOSURES
    var section01 = [SheeMenuFormModel]()
    var section02 = [SheeMenuFormModel]()
    private var viewModel = [ [ SheeMenuFormModel ] ]()
    
    func interactorGetData() {
        self.remoteDatamanager?.formGetData()
    }
}


// MARK: - OUTPUT
extension SheeMenuProfileInteractor: SheeMenuProfileRemoteDataManagerOutputProtocol {
    func remoteCallBackData(section01: [SheeMenuFormModel], section02: [SheeMenuFormModel]) {
        // SECTION 01
        for item in section01 {
            let model = SheeMenuFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section01.append(model)
        }
        self.viewModel.append(self.section01)

        // SECTION 02
        for item in section02 {
            let model = SheeMenuFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section02.append(model)
        }
        self.viewModel.append(self.section02)
        
        // DEVOLVER DATOS AL PRESENTER.
        self.presenter?.interactorCallBackData(with: self.viewModel)
    }
}
