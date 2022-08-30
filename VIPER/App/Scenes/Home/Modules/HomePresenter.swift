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
    
    // MARK:  PROPERTIES
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    var token = Token()
    
    // MARK:  Closures
    var viewModel: [HomeFeedRenderViewModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }
}


// MARK: - HOME PRESENT PROTOCOL >
extension HomePresenter: HomePresenterProtocol {

    func viewDidLoad() {
        
        /*
         - ------------ LLAMAR AL INTERACTOR -------------
         - DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS.
         */
        guard let token = token.getUserToken().success else { return }
        self.interactor?.interactorGetData(token: token)
        view?.startActivity()
    }
    
    func presenterNumberOfSections() -> Int {
        self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        let count = section
        let boxes = 7
        let position = count % 7 == 0 ? count / 7 : ((count - (count % 7)) / 7)
        model = self.viewModel[position]
        let subSection = count % boxes
        switch subSection {
            case 1:  return 1 // HEADER
            case 2:  return 1 // POST
            case 3:  return 1 // ACTION
            case 4:  return 1 // DESCRIPTION
            //case 5:  return 2 // COMMENT
            case 5:
            let commentsModel = model.comments
            switch commentsModel.renderType {
                case .comments( comments: let comments ): return comments.count > 2 ? 2 : comments.count
                case .header, .descriptions, .actions, .primaryContent, .footer: return 0
            }
            case 6:  return 1 // FOOTER
            default:  return 0
        }
    }
    
    func cellForRowAt(at index: Int) -> HomeFeedRenderViewModel {
        return self.viewModel[index]
    }
    
    /*
     - ------------ LLAMAR AL WIREFRAME -------------
     - PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (PROFILE)
     */
    func gotoProfileScreen(id: Int, name: String, token: String) {
        print("Cambiar de pantalla...")
        self.wireFrame?.navigateToProfile(from: view!, id: id, name: name, token: token)
    }
    
    /*
     - ------------ LLAMAR AL WIREFRAME -------------
     - PRESENTER LLAMA AL WIREFRAME PARA CAMBIAR PANTALLA (COMMENTS)
     */
    func gotoCommentsScreen(userpost: Post) {
        self.wireFrame?.navigateToComments(from: view!, userpost: userpost)
    }
}



// MARK: - OUTPUT HOME INTERACTOR PROTOCOL <
extension HomePresenter: HomeInteractorOutputProtocol {
    
    /*
     - ------------ LLAMAR AL VIEW -------------
     - EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE LE ENVIA EL INTERACTOR.
     - PARA TRATARLO Y FINALMENTE DEBE ENVIARLO
     - A LA VISTA BIEN "MASTICADITO"
     */
    func interactorCallBackData(with homeFeedRenderViewModel: [HomeFeedRenderViewModel]) {
        self.viewModel = homeFeedRenderViewModel
        view?.stopActivity()
    }
}
