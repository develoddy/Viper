import UIKit

// MARK: PRESENTER
class SheeMenuProfilePresenter  {
    
    // MARK: PROPERTIES
    weak var view: SheeMenuProfileViewProtocol?
    var interactor: SheeMenuProfileInteractorInputProtocol?
    var wireFrame: SheeMenuProfileWireFrameProtocol?
    
    // MARK: CLOSURES
    private var viewModel = [ [ SheeMenuFormModel ] ]()
}

extension SheeMenuProfilePresenter: SheeMenuProfilePresenterProtocol {
    func viewDidLoad() {
        // LLAMAR AL INTERACTOR
        self.interactor?.interactorGetData()
    }
    
    func presenterNumberOfSections() -> Int {
        return self.viewModel.count
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        return self.viewModel[section].count
    }
    
    func showData(indexPath: IndexPath) -> SheeMenuFormModel? {
        return self.viewModel[indexPath.section][indexPath.row]
    }
    
    func chooseOptions(indexPath: IndexPath, in viewController: UIViewController) {
        if indexPath.section == 0 {
            // CODE
        } else {
            if indexPath.section == 1 {
                switch indexPath.item {
                case 0:
                    print("opcion añadir cuenta")
                    break
                case 1:
                    presentKeyboard(in: viewController)
                    print("opcion salir")
                    break
                    
                default:print("dafult")
                }
            }
        }
    }
    
    func presentKeyboard(in viewController: UIViewController) {
        
        let alert = UIAlertController(
            title: "¿Seguro que quieres salir?",
            message: "",
            preferredStyle: .actionSheet)
        
   
        let closeAction = UIAlertAction(title: "Salir", style: .default) { (action) in
            // LLAMAR AL PRESENTER
            self.wireFrame?.gotoLoginView(from: self.view!)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alert.addAction(closeAction)
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
        topVC = topVC?.presentedViewController
        return topVC!
    }
   
}



// MARK: - OUT
extension SheeMenuProfilePresenter: SheeMenuProfileInteractorOutputProtocol {
    func interactorCallBackData(with viewModel: [[SheeMenuFormModel]]) {
        self.viewModel = viewModel
    }
}
