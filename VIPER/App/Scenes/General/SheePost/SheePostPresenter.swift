
import UIKit

class SheePostPresenter  {
    
    // MARK: PROPERTIES
    weak var view: SheePostViewProtocol?
    var interactor: SheePostInteractorInputProtocol?
    var wireFrame: SheePostWireFrameProtocol?
    var postReceivedFromPost: PostViewData? //Post?
    var indexPathReceivedFromProfile: IndexPath?
    var token = Token()
    var viewModelPost: [Post] = []
    
    // MARK: CLOSURES
    private var viewModel = [ [ SheePostFormModel ] ]()
}

extension SheePostPresenter: SheePostPresenterProtocol {
    func viewDidLoad() {
        /* --- LLAMAR AL PRESENTER ---
         * SE INTENTA OBTENER LOS DATOS PARA MOSTRAR EN LA VISTA
         * LOS DATOS SERÁ EL MENU DEL SHEE.
         */
        self.interactor?.interactorGetData()
    }
    
    /* --- TABLEVIEW ---
     * NUMERO DE SECCIONES.
     */
    func presenterNumberOfSections() -> Int {
        return self.viewModel.count
    }
    
    /* --- TABLEVIEW ---
     * TOTAL DE NUMERO DE FILAS DE SECCION.
     */
    func numberOfRowsInsection(section: Int) -> Int {
        return self.viewModel[section].count
    }
    
    /* --- TABLEVIEW ---
     * DATA VIEWMODEL RUTA DE INDICE DE SECCION Y FILAS
     */
    func showData(indexPath: IndexPath) -> SheePostFormModel? {
        return self.viewModel[indexPath.section][indexPath.row]
    }
    
    /*
     * SE OBTIENE LA PUBLICACIÓN
     */
    func getPost() -> /*Post?*/ PostViewData? {
        return self.postReceivedFromPost
    }
    
    
    /* --- UISEETPRESENTATIONCONTROLLER ---
     * SE MUESTRA EL SHEET PARA
     * ELEGIR UNAS DE LAS OPCIONES.
     */
    func choosePostOptions(indexPath: IndexPath, in viewController: UIViewController)  {
        if indexPath.section == 0 {
            // CODE
        } else {
            if indexPath.section == 1 {
                switch indexPath.item {
                case 0:
                    self.view?.dismiss()
                    presentKeyboard(in: viewController)
                    break
                case 1:
                    self.view?.dismiss()
                    present(in: viewController, indexPath: self.indexPathReceivedFromProfile!)
                    break
                    
                default:print("dafult")
                }
            }
        }
    }
    
    func presentKeyboard(in viewController: UIViewController) {
        guard let content = self.postReceivedFromPost?.content else {
            return
        }
        
        let alert = UIAlertController(
            title: Constants.PostView.alertUpdateTitle,
            message: content,
            preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = content
        }
        
        let saveAction = UIAlertAction(title: Constants.PostView.alertUpdateActionSave, style: .default) { (action) in
            /* --- LLAMAR AL PRESENTER ---
             * EN ESTE PUNTO SE INTENTARA MODIFICAR EL CONTENIDO LA PUBLICACIÓN.
             * Y VOLVER AL MODULO POSTVIEW.
             */
            guard let textFields = alert.textFields,
                  let token = self.token.getUserToken().success else { return }
            if let contentText = textFields[0].text {
                self.postReceivedFromPost?.content = contentText
            }
            self.interactor?.interactorUpdatePost(post: self.postReceivedFromPost, token: token)
            /* DESPUES DE ACTUALIZAR EL CONTENIDO DE LA PUBLICACIÓN VAMOS A CERRAR
             * EL ALERT Y POSICIOARNOS EN LA PUBLICACIÓN
             */
            
            let currentTopVC: UIViewController? = self.currentTopViewController()
            alert.dismiss(animated: true)
            self.wireFrame?.gotoPost(from: currentTopVC!, post: self.postReceivedFromPost)
           
        }
        let cancelAction = UIAlertAction(title: Constants.PostView.alertUpdateActionCancel, style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        let currentTopVC: UIViewController? = self.currentTopViewController()
        currentTopVC?.present(alert, animated: true, completion: nil)
    }
    
    
    
    /* ---- UIALERTCONTROLLER ----
     * DESPUES DE ELEJIR LA OPCION EN SHEET
     * SE MOESTRARÁ UN ALERT DE CONFIRMACIÓN
     */
    func present( in viewController: UIViewController, indexPath: IndexPath ) {
        let alert = UIAlertController(
            title: Constants.PostView.alertDeleteTitle,
            message: Constants.PostView.alertDeleteMessage,
            preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: Constants.PostView.alertDeleteActionTitle, style: .default) { (action) in
            /* --- LLAMAR AL PRESENTER ---
             * EN ESTE PUNTO SE INTENTARA BORRAR LA PUBLICACIÓN
             * Y VOLVER AL MODULO POSTVIEW.
             */
            guard let userId = self.token.getUserToken().user?.id,
                  let token = self.token.getUserToken().success else {
                return
            }
            self.interactor?.interactorDeletePost(post: self.postReceivedFromPost, token: token)
            alert.dismiss(animated: true)
            let currentTopVC: UIViewController? = self.currentTopViewController()
            self.wireFrame?.sendDataPost(from: currentTopVC!, userId: userId, token: token, indexPath: self.indexPathReceivedFromProfile!)
        }
        let cancelAction = UIAlertAction(title: Constants.PostView.alertDeleteActionCancel, style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        let currentTopVC: UIViewController? = self.currentTopViewController()
        currentTopVC?.present(alert, animated: true, completion: nil)
    }
    
    /*
     * ROOT VIEW CONTROLLER
     * SE CONFIGURA LA PRESENTACION DEL ALERT ANTES DE MOSTRARSE.
     */
    func currentTopViewController() -> UIViewController {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        var topVC: UIViewController? = keyWindow?.rootViewController
        topVC = topVC?.presentedViewController
        return topVC!
    }
    
    
   
}





// MARK: - OUT PUT

extension SheePostPresenter: SheePostInteractorOutputProtocol {
   
    /* --- DATOS QUE VIENE DEL INTERACTOR ---
     * EN ESTE PUNTO SE RECIBE TODO LOS DATOS QUE
     * VIENE DEL INTERACTOR.
     */
    func interactorCallBackData(with viewModel: [[SheePostFormModel]]) {
        self.viewModel = viewModel
    }
    
    
    // EN ESTE PUNTO SE RECIBE DATOS QUE LLEGAN DESDE EL INTERACTOR.
    func interactorCallBackDeletePost(with delete: Bool) {
       //-
    }
    
    func interactorCallBackPosts(with viewModel: [Post]) {
        //-
    }
}
