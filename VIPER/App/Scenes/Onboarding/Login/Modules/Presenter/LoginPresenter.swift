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
    
    // VAMOS A LLAMAR AL WIREFRAME
    func showTabBar(email: String?, password: String?) {
        interactor?.interactorGetData(email: email, password: password)
        view?.startActivity()
    }
}



// MARK: PRESENTER OutputProtocol
extension LoginPresenter: LoginInteractorOutputProtocol {
    
    // RECIBE UN BOLEANO SI EL USUARIO FUE LOGUEADO CORRECTAMENTE O INCORRECTAMENTE
    // SI ES CORRECTO ENTONCES LLAMAMOS AL WIREFRAME PARA CAMBIO DE PANTALLA (TAB BAR CONTOLLER)
    // SI ES INCORRECTO ENTONCES "YA VEREMOS"...
    func interactorCallBackData(success: Bool) {
        ///print("LoginPresenter devuelta  Login Success !!! > \(success)")
        view?.stopActivity()
        wireFrame?.presentNewTabBarController()
    }
}
