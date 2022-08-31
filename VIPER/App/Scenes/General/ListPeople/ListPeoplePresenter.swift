//
//  ListPeoplePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 31/8/22.
//  
//

import Foundation

class ListPeoplePresenter: ListPeoplePresenterProtocol  {
    
    // MARK: Properties
    weak var view: ListPeopleViewProtocol?
    var interactor: ListPeopleInteractorInputProtocol?
    var wireFrame: ListPeopleWireFrameProtocol?
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension ListPeoplePresenter: ListPeopleInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
