import Foundation

class EditProfilePresenter: EditProfilePresenterProtocol  {
    
    // MARK: PROPERTIES
    weak var view: EditProfileViewProtocol?
    var interactor: EditProfileInteractorInputProtocol?
    var wireFrame: EditProfileWireFrameProtocol?
    var userReceivedFromProfile: UserViewData? //User?
    
    // MARK: CLOSURES
    private var viewModel = [ [ EditProfileFormModel ] ]()
    
    // TODO: IMPLEMENT PRESENTER METHODS.
    func viewDidLoad() {
        self.interactor?.interactorGetData()
    }
    
    func presenterNumberOfSections() -> Int {
        return self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        return self.viewModel[section].count
    }
    
    func showData(indexPath: IndexPath) -> EditProfileFormModel? {
        return self.viewModel[indexPath.section][indexPath.row]
    }
    
    func showImageProfile() -> String? {
        return userReceivedFromProfile?.imageHeader
    }
}


// MARK: - OUT PUT
extension EditProfilePresenter: EditProfileInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    func interactorCallBackData( with viewModel: [ [ EditProfileFormModel ] ] ) {
        self.viewModel = viewModel
    }
    
    
}
