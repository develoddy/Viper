//
//  HomePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

// MARK: PRESENTER
class HomePresenter  {
    
    // MARK: Properties
    // Anexo de union con el Interactor & WireFrame
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
}

// MARK: Extension HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
        interactor?.interactorGetData()
    }
}

// MARK: Extension HomeInteractorOutputProtocol
extension HomePresenter: HomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
