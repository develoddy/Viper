//
//  LoginUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/1/22.
//

import UIKit

// MARK: UI
class LoginUI: UIView {
    
    //var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let gradient = CAGradientLayer()
    
    public let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .blue
        return headerView
    }()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "T I M W I D E R"
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    public let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "EMAIL"
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
    
    public let emailText : TextFieldWithPadding = {
        let emailText = TextFieldWithPadding()
        emailText.placeholder = "Username or Email"
        emailText.text = "eddylujann@gmail.com"
        emailText.returnKeyType = .next
        emailText.leftViewMode = .always
        emailText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailText.autocapitalizationType = .none
        emailText.autocorrectionType = .no
        emailText.layer.masksToBounds = true
        emailText.textColor =  .black
        emailText.backgroundColor = .systemBackground
        return emailText
    }()
    
    public let passwordText : TextFieldWithPadding = {
        let passwordText = TextFieldWithPadding()
        passwordText.isSecureTextEntry = true
        passwordText.placeholder = "Password"
        passwordText.text = "secret"
        passwordText.returnKeyType = .continue
        passwordText.leftViewMode = .always
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordText.autocapitalizationType = .none
        passwordText.autocorrectionType = .no
        passwordText.layer.masksToBounds = true
        passwordText.textColor =  .black
        passwordText.backgroundColor = .systemBackground
        return passwordText
    }()
    
    //    public let loginButton : UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Login", for: .normal)
    //        button.backgroundColor = .blue
    //        return button
    //    }()
    
    
    public let loginButton : LoadingButton = {
        let button = LoadingButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    public let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Serviced", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        // button.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        return button
    }()
    
    public let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Polocy", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        // button.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        return button
    }()
    
    public let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        // button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // SETUP
    private func setupView() {
        backgroundColor = .systemBackground
        
        self.addSubview(headerView)
        
        self.addSubview(emailLabel)
        self.addSubview(emailText)
        
        self.addSubview(passwordLabel)
        self.addSubview(passwordText)
        
        self.addSubview(loginButton)
        self.addSubview(termsButton)
        self.addSubview(privacyButton)
        self.addSubview(createAccountButton)
        
        //self.addSubview(activityIndicator)
    }
    
    // LAYOUT SUB VIEWS
    override func layoutSubviews() {
        
        // HEADER
        headerView.frame = CGRect(x: 0,y: 0.0,width: self.width,height: self.height/3.0)
        
        // LOGO
        let size = headerView.height/3
        logoImageView.frame = CGRect(x: (self.width-size)/2, y:(headerView.height-size)/2.5, width:size, height: size)
        logoImageView.layer.cornerRadius = logoImageView.height/2
        
        // TITLE
        titleLabel.frame = CGRect(x:10, y:logoImageView.bottom+40, width: width-20, height:30)
        
        // EMAIL
        let emailLabellSize = emailLabel.sizeThatFits(self.frame.size)
        emailLabel.frame = CGRect(x: 25, y: headerView.bottom+20, width: width-50, height: emailLabellSize.height).integral
        let emailTextlSize = emailText.sizeThatFits(self.frame.size)
        emailText.frame = CGRect(x: 25, y: emailLabel.bottom+5, width: width-50, height: emailTextlSize.height).integral
        
        // PASSWORD
        let passwordLabelize = passwordLabel.sizeThatFits(self.frame.size)
        passwordLabel.frame = CGRect(x: 25, y: emailText.bottom+20, width: self.width-50, height:passwordLabelize.height).integral
        let passwordTextlSize = passwordText.sizeThatFits(self.frame.size)
        passwordText.frame = CGRect(x:25, y: passwordLabel.bottom+5, width:self.width-50, height:passwordTextlSize.height).integral
        
        // BUTTON LOGIN
        loginButton.frame = CGRect(x:40, y: passwordText.bottom+20, width: width-80, height:50)
        loginButton.layer.cornerRadius = loginButton.height/2
        
        // BUTTON TERMS
        termsButton.frame = CGRect(x:10, y:self.height-self.safeAreaInsets.bottom-100, width:self.width-20, height: 50)
        
        // BUTTTON PRIVACY
        privacyButton.frame = CGRect(x:10, y:self.height-self.safeAreaInsets.bottom-50, width:self.width-20, height:50)
        
        // BUTTON CREATE ACCOUNT
        createAccountButton.frame = CGRect(x:25, y:loginButton.bottom+10, width:self.width-50, height: 52.0)
        
    }
    
    
    // HEADER VIEW
    func configureHeaderView() {
        // COLOR HEADER
        headerView.clipsToBounds = true
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBackground.cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = self.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        
        // LOHO
        logoImageView.backgroundColor = .systemBackground
        logoImageView.layer.masksToBounds = true
        
        // ADD LOGO & TITLE
        headerView.addSubview(logoImageView)
        headerView.addSubview(titleLabel)
    }
}
