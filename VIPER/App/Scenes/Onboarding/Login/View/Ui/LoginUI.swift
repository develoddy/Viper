//
//  LoginUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/1/22.
//

import UIKit

// MARK: UI
class LoginUI: UIView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Timwider"
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    public let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "Correo electronico"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public let passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Constraseña"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public let emailText : UITextField = {
        let textField = UITextField()
        textField.text = "eddylujann@gmail.com"
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.backgroundColor = .systemGray4
        return textField
    }()
    
    public let passwordText : UITextField = {
        let textField = UITextField()
        textField.text = "secret"
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.backgroundColor = .systemGray4
        return textField
    }()
    
    public let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup View
    private func setupView() {
        backgroundColor = .systemBackground
        self.addSubview(titleLabel)
        
        self.addSubview(emailLabel)
        self.addSubview(emailText)
        
        self.addSubview(passwordLabel)
        self.addSubview(passwordText)
        
        self.addSubview(loginButton)
        
        self.addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 10, y: 10, width: width - 20 , height: 30)
        
        // Email
        let emailSize = emailLabel.sizeThatFits(self.frame.size)
        emailLabel.frame = CGRect(x: 10, y: titleLabel.bottom+40, width: width-20, height: emailSize.height).integral
        emailText.frame = CGRect(x: 10, y: emailLabel.bottom+2, width: width-20, height: 20)
        
        // Password
        let passwordSize = passwordLabel.sizeThatFits(self.frame.size)
        passwordLabel.frame = CGRect(x: 10, y: emailText.bottom+20, width: width-20, height: passwordSize.height).integral
        passwordText.frame = CGRect(x: 10, y: passwordLabel.bottom+2, width: width-20, height: 20)
        
        // Button
        loginButton.frame = CGRect(x: 40, y: passwordText.bottom+20, width: width-80, height: 30)
        loginButton.layer.cornerRadius = loginButton.height/2
        
    }
    
    func configureSpinner() {
        activityIndicator.hidesWhenStopped = false
    }
}
