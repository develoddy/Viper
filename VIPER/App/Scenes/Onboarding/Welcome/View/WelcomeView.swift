import Foundation
import UIKit

class WelcomeView: UIViewController {

    // MARK: PROPERTIES
    var presenter: WelcomePresenterProtocol?
    var welcomeUI = WelcomeUI()

    // MARK: LIFECICLY

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    func initMethods() {
        setupView()
        loadData()
        tapLogIn()
        tapSignUp()
    }
    
    func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(welcomeUI)
    }
    
    override func viewDidLayoutSubviews() {
        welcomeUI.frame = view.bounds
    }
    
    private func loadData() {
        presenter?.viewDidLoad()
    }
    
    func tapLogIn() {
        let loginButton = welcomeUI.logInButton
        loginButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
    }
    
    func tapSignUp() {
        let signUpButton = welcomeUI.signUpButton
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    // TAP LOGIN
    @objc private func didTapLogInButton() {
        presenter?.navigateToLoginView()
    }
    
    // TAP REGISTER
    @objc private func didTapSignUpButton() {
        presenter?.navigateToUsernameView()
    }
}

extension WelcomeView: WelcomeViewProtocol {
    // TODO: implement view output methods
}
