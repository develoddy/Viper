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
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
    // Initialize the Token App.
    var token = Token()
    
    // MARK: - Closures
    
    var viewModel: [HomeFeedRenderViewModel] = [] {
        didSet {
            ///self.view?.startActivity()
            self.view?.updateUIList()
        }
    }
}


// MARK: - HOME PRESENT PROTOCOL >
extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        // TOKEN
        guard let token = token.getUserToken().token else { return }
        
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
        view?.startActivity()
        //DispatchQueue.main.async {
            self.interactor?.interactorGetData(token: token)
        //}
    }
    
    func presenterNumberOfSections() -> Int {
        self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
//        if self.viewModel.count != 0 {
//            return self.viewModel.count
//        }
//        return 0
        let count = section
        let boxes = 7
        let subSection = count % boxes
        switch subSection {
            case 1:  return 1 // Header
            case 2:  return 1 // Post
            case 3:  return 1 // Actions
            case 4:  return 1 // Description
            case 5:  return 1 // Comments
            case 6:  return 1 // Footer
            default:  return 0
        }
    }
    
    //func cellForRowAt(indexPath: IndexPath) -> HomeFeedRenderViewModel {
    
    func cellForRowAt(at index: Int) -> HomeFeedRenderViewModel {
        return self.viewModel[index]
    }
    
}



// MARK: - HOME INTERACTOR OUT PUT PROTOCOL <
extension HomePresenter: HomeInteractorOutputProtocol {
    
    // EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE ENVIA EL INTERACTOR
    // EL PRESENTER ENVIAR EL ARRAY OBJETO AL VIEW
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel]) {
        //view?.presenterPsuhDataView(receivedData: homeFeedRenderViewModel)
        
        
        view?.stopActivity()
        self.viewModel = homeFeedRenderViewModel
        
        //print("self.viewModel")
        //print(self.viewModel)
    }
}
