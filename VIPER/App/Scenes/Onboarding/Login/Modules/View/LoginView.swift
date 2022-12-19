import UIKit

class LoginView: UIViewController {

    // MARK: PROPERTIES
    var presenter: LoginPresenterProtocol?
    var loginUI = LoginUI()
    
    // MARK: LIFECICLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    func initMethods() {
        upKeyboard()
        setupView()
        loadData()
        setupView()
        setupLeftNavItems()
        didTapLoginButton()
    }
    
    func loadData() {
        presenter?.viewDidLoad()
    }
    
    // SETUPVIEW
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(loginUI)
        let loginButton = loginUI.loginButton
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        self.loginUI.emailText.delegate = self
        self.loginUI.passwordText.delegate = self
        self.loginUI.messageLoginIncorrectLabel.isHidden = true
        
        // LOGIN ENABLED
        self.loginUI.loginButton.backgroundColor = Constants.Color.lightDark
        self.loginUI.loginButton.isEnabled = false
        
        // textField.enablesReturnKeyAutomatically = true
        self.loginUI.emailText.enablesReturnKeyAutomatically = true
        self.loginUI.passwordText.enablesReturnKeyAutomatically = true
    }
    
    
    // SE CONFIGURA LOS ITEM EN EL NAVIGATION.
    func setupLeftNavItems() {
        let buttonPlusIcon = UIImage(systemName: "chevron.left")
        let leftBarPlusButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapUploadPost))
        leftBarPlusButton.image = buttonPlusIcon
        leftBarPlusButton.tintColor = Constants.Color.primary
        
        navigationItem.leftBarButtonItems = [
            leftBarPlusButton
        ]
    }
    
    // ACCION BUTTONS
    @objc func didTapUploadPost() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade //CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        self.loginUI.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginUI.emailText.becomeFirstResponder()
        
    }
    
    // TAP LOGIN
    @objc private func didTapLoginButton() {
        guard let email = loginUI.emailText.text, let password = loginUI.passwordText.text else { return }
        // LLAMAMOS AL PRESENTER ENVIDANDOLE EL EMAIL & PASSWORD
        self.presenter?.showTabBar( email: email, password: password )
        self.loginUI.emailText.resignFirstResponder() // dismiss keyboard
        self.loginUI.passwordText.resignFirstResponder()
        self.loginUI.bottomConstraint?.constant = 0
    }
    
    func upKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // KEYBOARD
    @objc private func handleKeyboardNotification( notification: NSNotification ) {
        if let userInfo: NSValue = notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue {
            let keyboardFrame = userInfo.cgRectValue
            let isKeyBoardShowing = notification.name == UIResponder.keyboardWillShowNotification
            loginUI.bottomConstraint?.constant = isKeyBoardShowing ? -keyboardFrame.height: 0
            UIView.animate(withDuration: 0,delay: 0,options: UIView.AnimationOptions.curveEaseOut,animations: {
                self.view.layoutIfNeeded()
            }, completion: { ( completed ) in
                // CODE
            })
        }
    }
}


// MARK: - OU TPUT LOGIN
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
        self.loginUI.messageLoginIncorrectLabel.isHidden = false
        self.loginUI.passwordText.becomeFirstResponder()
        /*let alert = UIAlertController(title: Constants.LogInError.title, message: Constants.LogInError.mensajeError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            // NSLog("The \"OK\" alert occured.")
            self.loginUI.passwordText.becomeFirstResponder()
        }))
        self.present(alert, animated: true, completion: nil)
         */
    }
}

// MARK: - TECLADO DELEGATE
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.loginUI.emailText {
            self.loginUI.passwordText.becomeFirstResponder()
        } else if textField == self.loginUI.passwordText {
            self.didTapLoginButton()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 0  {
            textField.enablesReturnKeyAutomatically = true
            self.loginUI.loginButton.backgroundColor = Constants.Color.lightDark
            self.loginUI.loginButton.isEnabled = false
        } else {}
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.loginUI.emailText.text?.count == 0 || self.loginUI.passwordText.text?.count == 0  {
            self.loginUI.loginButton.backgroundColor = Constants.Color.lightDark
            self.loginUI.loginButton.isEnabled = false
            self.loginUI.messageLoginIncorrectLabel.isHidden = true
        } else {
            self.loginUI.loginButton.backgroundColor = Constants.Color.cyan
            self.loginUI.loginButton.isEnabled = true
        }
    }
}
