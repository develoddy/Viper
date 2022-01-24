//
//  SearchPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation

class SearchPresenter  {
    
    // MARK: Properties
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var wireFrame: SearchWireFrameProtocol?
    
}

extension SearchPresenter: SearchPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
