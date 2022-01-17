//
//  HomeInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: - Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    // DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER) QUE TIENE QUE TRAER UNOS DATOS
    func interactorGetData(token: String) {
        remoteDatamanager?.remoteGetData(token: token)
        //remoteDatamanager?.remoteGetData(token: token) { userpost in }
    }
}


extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    
    // EL INTERACTOR DEBE ENVIARLE LOS DATOS AL PRESENTER BIEN "MASTICADITO"
    func remoteCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel]) {
        presenter?.interactorCallBackData(with: homeFeedRenderViewModel)
    }
    
}
