import UIKit

class LoginView: UIViewController {

    // MARK: PROPERTIES
    var presenter: LoginPresenterProtocol?
    var loginUI = LoginUI()
    
    // MARK: LIFECICLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    // SETUPVIEW
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(loginUI)
        let loginButton = loginUI.loginButton
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        didTapLoginButton()
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        self.loginUI.frame = view.bounds
    }
    
    // TAP LOGIN
    @objc private func didTapLoginButton() {
        guard let email = loginUI.emailText.text, let password = loginUI.passwordText.text else { return }
        // LLAMAMOS AL PRESENTER ENVIDANDOLE EL EMAIL & PASSWORD
        self.presenter?.showTabBar( email: email, password: password )
        
    }
}



// MARK: - OU TPUT LOGIN

// LA VISTA ES LLAMADO DESDE EL PRESENTER.
extension LoginView: LoginViewProtocol {
   
    // ANIMATE ACTIVITY
    func startActivity() {
        DispatchQueue.main.async {
            self.loginUI.loginButton.showLoading()
        }
    }
    
    // STOP ACTIVITY
    func stopActivity() {
        self.loginUI.loginButton.hideLoading()
    }
    
    // ERROR LOGIN.
    func onError() {
        let alert = UIAlertController(title: Constants.LogInError.title, message: Constants.LogInError.mensajeError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            // NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
