//
//  LoginView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import UIKit


// MARK: VIEW CONTROLLER
class LoginView: UIViewController {

    // MARK: PROPERTIES
    var presenter: LoginPresenterProtocol?
    var loginUI = LoginUI()
    
    
    // MARK: - LIFECICLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //presenter?.viewDidLoad()
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
        presenter?.showTabBar(email: email, password: password)
    }
}



// MARK: - OUTPUT LOGIN VIEW PROTOCOL
/// LA VISTA ES LLAMADO DESDE EL PRESENTER
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
}
