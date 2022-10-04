import Foundation

class EditProfileRemoteDataManager:EditProfileRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: EditProfileRemoteDataManagerOutputProtocol?
    
    // SETUP DATA
    func localGetData() {
        let section1Labels = ["Nombre", "Username" , "Biografia"]
        
        // ------------- ENVIAR DATOS AL INTERACTOR -------------
        // EN ESTE PUNTO SE DEVUELVE LOS DATOS AL INTERACTOR.
        self.remoteRequestHandler?.remoteCallBackData(with: section1Labels)
    }
    
}
