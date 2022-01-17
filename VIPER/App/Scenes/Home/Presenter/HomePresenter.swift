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
    
    // Initialize the Token App.
    var token = Token()
    
    // MARK: - Closures
    // Through these closures, our view model will execute code while some events will occure
    // They will be set up by the view controller
    var reloadTableViewClosure : (()->())?
    var showAlertClosure            : (()->())?
    var updateLoadingStatusClosure  : (()->())?
    
    // This will contain info about the picture eventually selectded by the user by tapping an item on the screen
    var selectedHome: HomeFeedRenderViewModel?
    
    // The collection that will contain our fetched data
    var viewModel: [HomeFeedRenderViewModel] = [HomeFeedRenderViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // The collection that will contain our fetched data
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
}

// MARK: Extension HomePresenterProtocol >
extension HomePresenter: HomePresenterProtocol {
    
    
    func viewDidLoad() {
        // TOKEN
        guard let token = token.getUserToken().token else { return }
        
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
        interactor?.interactorGetData(token: token)
    }
    
    func presenterNumberOfSections() -> Int {
        return viewModel.count
    }
    
}

// MARK: Extension HomeInteractorOutputProtocol <
extension HomePresenter: HomeInteractorOutputProtocol {
    
    // EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE ENVIAR EL INTERACTOR
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel]) {
        self.viewModel = homeFeedRenderViewModel
    }
    
}
