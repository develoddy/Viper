import Foundation

class EditProfileInteractor: EditProfileInteractorInputProtocol {
    
    // MARK: PROPERTIES
    weak var presenter: EditProfileInteractorOutputProtocol?
    var localDatamanager: EditProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: EditProfileRemoteDataManagerInputProtocol?
    var section1 = [EditProfileFormModel]()
    
    // MARK: CLOSURES
    private var viewModel = [ [ EditProfileFormModel ] ]()
    
    /* ------------ LLAMAR AL EXTERNALDATAMANEGER -------------
     * DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER)
     * QUE TIENE QUE TRAER UNOS DATOS.
     */
    func interactorGetData() {
        self.remoteDatamanager?.localGetData()
    }

}


// MARK: - OUT PUT
extension EditProfileInteractor: EditProfileRemoteDataManagerOutputProtocol {
    
    
    /* ------------ LLAMAR AL PRESENTER -------------
     * EN ESTE PUNTO EL INTERACTOR HA RECIBIDO DATOS DE LA CAPA EXTERNALDATAMANAGER,
     * Y TENDREMOS QUE PASARLE A LA CAPA DEL PRESENTER.
     */
    func remoteCallBackData( with section: [String] ) {
        for label in section {
            let model = EditProfileFormModel(
                            label: label,
                            placeHolder: "Cual es su \(label)",
                            value: nil)
            section1.append( model )
        }
        
        self.viewModel.append( section1 )
        self.presenter?.interactorCallBackData(with: self.viewModel)
    }

}
