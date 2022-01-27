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
    
    // MARK: - PROPERTIES
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    var token = Token()
    
    // MARK: - Closures
    var viewModel: [HomeFeedRenderViewModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }
}


// MARK: - HOME PRESENT PROTOCOL >
extension HomePresenter: HomePresenterProtocol {

    func viewDidLoad() {
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
        guard let token = token.getUserToken().token else { return }
        self.interactor?.interactorGetData(token: token)
        view?.startActivity()
    }
    
    func presenterNumberOfSections() -> Int {
        self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        let count = section
        let boxes = 7
        let subSection = count % boxes
        switch subSection {
            case 1:  return 1 // HEADER
            case 2:  return 1 // POST
            case 3:  return 1 // ACTION
            case 4:  return 1 // DESCRIPTION
            case 5:  return 1 // COMMENT
            case 6:  return 1 // FOOTER
            default:  return 0
        }
    }
    
    func cellForRowAt(at index: Int) -> HomeFeedRenderViewModel {
        return self.viewModel[index]
    }
    
    // PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (PROFILE)
    func gotoProfileScreen(email: String, name: String, token: String) {
        self.wireFrame?.navigateToProfile(from: view!, email: email, name: name, token: token)
    }
    
    // PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (COMMENTS)
    func gotoCommentsScreen(userpost: Userpost) {
        self.wireFrame?.navigateToComments(from: view!, userpost: userpost)
    }
}



// MARK: - OUTPUT HOME INTERACTOR PROTOCOL <
extension HomePresenter: HomeInteractorOutputProtocol {
    
    // EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE ENVIA EL INTERACTOR
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel]) {
        self.viewModel = homeFeedRenderViewModel
        view?.stopActivity()
    }
}
