import Foundation


// MARK: PRESENTER
class LoginPresenter  {
    
    // MARK: PROPERTIES
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
}

extension LoginPresenter: LoginPresenterProtocol {

    func viewDidLoad() {
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
    }
    

    /* ----------- LLAMAR AL INTERACTOR --------------
     - VAMOS A LLAMAR AL INTERACTOR PANSANDOLE
     - EL NOMBRE DE USUARIO Y CONTRASEÑA.
     */
    func showTabBar( email: String?, password: String? ) {
        interactor?.interactorGetData(email: email, password: password)
        view?.startActivity()
    }
}





// MARK: - OUT PUT

extension LoginPresenter: LoginInteractorOutputProtocol {
   
    /* ----------- LOGUIN CON EXITO --------------
     - RECIBE UN BOLEANO SI EL USUARIO FUE LOGUEADO CORRECTAMENTE O INCORRECTAMENTE.
     - SI ES CORRECTO ENTONCES LLAMAMOS AL WIREFRAME PARA CAMBIO DE PANTALLA (TAB BAR CONTOLLER)
     */
    func interactorCallBackData(success: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.wireFrame?.presentNewTabBarController()
            self?.view?.stopActivity()
        }
    }
    
    /* ----------- ERROR LOGUIN --------------
     - EL INTERACTOR NO DICE QUE HUBO UN ERROR AL INENTAR LOGUEARSE EL USUARIO.
     */
    func interactorLoginFailed() {
        DispatchQueue.main.async {[weak self] in
            self?.view?.onError()
            self?.view?.stopActivity()
       }        
    }
}
