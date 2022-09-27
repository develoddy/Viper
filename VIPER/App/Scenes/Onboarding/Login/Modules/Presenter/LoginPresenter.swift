//
//  LoginPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation


// MARK: PRESENTER
class LoginPresenter  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
}

extension LoginPresenter: LoginPresenterProtocol {

    func viewDidLoad() {
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
    }
    

    /*
     - ----------- LLAMAR AL INTERACTOR --------------
     - VAMOS A LLAMAR AL INTERACTOS PANSANDOLE
     - EL NOMBRE DE USUARIO Y CONTRASEÑA.
     */
    func showTabBar( email: String?, password: String? ) {
        interactor?.interactorGetData(email: email, password: password)
        view?.startActivity()
    }
}



// MARK: PRESENTER OutputProtocol
extension LoginPresenter: LoginInteractorOutputProtocol {
   
    /*
     - ----------- INTERACTOR CALL BACK DATA --------------
     - RECIBE UN BOLEANO SI EL USUARIO FUE LOGUEADO CORRECTAMENTE O INCORRECTAMENTE
     - SI ES CORRECTO ENTONCES LLAMAMOS AL WIREFRAME PARA CAMBIO DE PANTALLA (TAB BAR CONTOLLER)
     - SI ES INCORRECTO ENTONCES "YA VEREMOS"...
     */
    func interactorCallBackData(success: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.wireFrame?.presentNewTabBarController()
            self?.view?.stopActivity()
        }
    }
    
    func interactorLoginFailed() {
        DispatchQueue.main.async {[weak self] in
            self?.view?.onError()
            self?.view?.stopActivity()
       }        
    }
}
