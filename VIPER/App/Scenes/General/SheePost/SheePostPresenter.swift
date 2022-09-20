
import UIKit

class SheePostPresenter  {
    
    // MARK: Properties
    weak var view: SheePostViewProtocol?
    var interactor: SheePostInteractorInputProtocol?
    var wireFrame: SheePostWireFrameProtocol?
    var postReceivedFromPost: Post?
    var token = Token()
    
    // MARK: CLOSURES
    private var viewModel = [ [ SheePostFormModel ] ]()
    
}

extension SheePostPresenter: SheePostPresenterProtocol {
   
    

    // TODO: implement presenter methods
    func viewDidLoad() {
        // LLAMAR AL PRESENTER
        self.interactor?.interactorGetData()
    }
    
    func presenterNumberOfSections() -> Int {
        return self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        return self.viewModel[section].count
    }
    
    func showData(indexPath: IndexPath) -> SheePostFormModel? {
        return self.viewModel[indexPath.section][indexPath.row]
    }
    
    func getPost() -> Post? {
        return self.postReceivedFromPost
    }
    

    func choosePostOptions(indexPath: IndexPath, in viewController: UIViewController)  {
        if indexPath.section == 0 {
        } else {
            if indexPath.section == 1 {
                switch indexPath.item {
                case 0: break
                case 1:
                    self.view?.dismiss()
                    present(in: viewController)
                default:print("dafult")
                }
            }
        }
    }
    
    func present( in viewController: UIViewController ) {
        let alert = UIAlertController(
            title: "¿Eliminar publicación?",
            message: "Podrás restaurar esta publicación duante los proximos 30 días desde 'Eliminados recientemente' en 'Tu Actividad' Transcurrido este tiempo, se eliminará definitivamente.",
            preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Eliminar", style: .default) { (action) in
            // CODE
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
                
        let currentTopVC: UIViewController? = self.currentTopViewController()
        currentTopVC?.present(alert, animated: true, completion: nil)
    }
    
    func currentTopViewController() -> UIViewController {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        var topVC: UIViewController? = keyWindow?.rootViewController
        //if let _ = topVC?.presentedViewController {
        topVC = topVC?.presentedViewController
        //}
        return topVC!
    }
    
    
    
    
}

extension SheePostPresenter: SheePostInteractorOutputProtocol {
    
    
    // TODO: IMPLEMENT INTERACTOS OUTPUT METHODS
    func interactorCallBackData(with viewModel: [[SheePostFormModel]]) {
        self.viewModel = viewModel
    }
    
    // BORRAR PUBLICACIÓN.
    func interactorCallBackDeletePost(with delete: Bool) {
       
        
        
        // LLAMAR AL WIREFRAME.
        wireFrame?.sendDataPost(from: self.view!, delete: delete)
    }
}
