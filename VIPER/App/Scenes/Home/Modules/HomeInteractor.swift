//
//  HomeInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//
//
import Foundation
// MARK: HOME INTERACTOR
class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK:  PROPERTIES
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    /*
     - ------------ LLAMAR AL EXTERNALDATAMANEGER -------------
     - DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER)
     - QUE TIENE QUE TRAER UNOS DATOS.
     */
    func interactorGetData(token: String) {
        remoteDatamanager?.remoteGetData( token: token )
    }
}


// MARK: - OUTPUT REMOTE MANAGER PROTOCOL
extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    /*
     - ------------ LLAMAR AL PRESENTER -------------
     - EL INTERACTOR DEBE ENVIARLE LOS DATOS AL
     - PRESENTER BIEN "MASTICADITO"
     */
    func remoteCallBackData( with homeFeedRenderViewModel: [ HomeFeedRenderViewModel ] ) {
        presenter?.interactorCallBackData( with: homeFeedRenderViewModel )
    }

}

