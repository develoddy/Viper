import UIKit

// MARK: UI
class LoginUI: UIView {
    
    let gradient = CAGradientLayer()
    var bottomConstraint: NSLayoutConstraint?
    
    public let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = Constants.Color.white
        return headerView
    }()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Iniciar sesión"
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = Constants.Color.black
        return label
    }()
    
    public let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "CORREO ELECTRÓNICO"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Constants.Color.gray
        return label
    }()
    
    public let passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "CONTRASEÑA"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Constants.Color.gray
        return label
    }()
    
    public let emailText : TextFieldWithPadding = {
        let emailText = TextFieldWithPadding()
        //emailText.placeholder = "Username or Email"
        emailText.text = Constants.LoginData.username
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
       // passwordText.placeholder = "Password"
        passwordText.text = Constants.LoginData.password
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
    
    public let loginButton : LoadingButton = {
        let button = LoadingButton()
        button.setTitle("Iniciar sesión", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = Constants.Color.cyan
        return button
    }()
    
    public let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Serviced", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        // button.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        return button
    }()
    
    public let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Polocy", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        // button.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        return button
    }()
    
    public let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Registrarse", for: .normal)
        button.setTitleColor(Constants.Color.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        // button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        return button
    }()
    
    public let forgottenPasswordButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("¿Has olvidado tu contraseña?", for: .normal)
        button.setTitleColor(Constants.Color.primary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        // button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        return button
    }()
    
    public let messageLoginIncorrectLabel : UILabel = {
        let label = UILabel()
        label.text = "Contraseña incorrecta; vuelve a intentarlo."
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Constants.Color.danger
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContainer()
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
        self.addSubview(forgottenPasswordButton)
        self.addSubview(containerView)
        self.addSubview(messageLoginIncorrectLabel)
        //self.addSubview(createAccountButton)
        //self.addSubview(termsButton)
        //self.addSubview(privacyButton)
        
        
    }
    
    // LAYOUT SUB VIEWS
    override func layoutSubviews() {
        
        // HEADER
        headerView.frame = CGRect(x: 0,y: 0.0,width: self.width,height: self.height/4)
        
        // LOGO
        let size = headerView.height/3
        logoImageView.frame = CGRect(x: (self.width-size)/2, y:(headerView.height-size)/2.5, width:size, height: size)
        logoImageView.layer.cornerRadius = logoImageView.height/2
        
        // TITLE
        titleLabel.frame = CGRect(x:10, y:logoImageView.bottom+40, width: width-20, height:30)
        
        // TEXT EMAIL
        let emailLabellSize = emailLabel.sizeThatFits(self.frame.size)
        emailLabel.frame = CGRect(x: 50, y: headerView.bottom+20, width: width-100, height: emailLabellSize.height).integral
        let emailTextlSize = emailText.sizeThatFits(self.frame.size)
        emailText.frame = CGRect(x: 50, y: emailLabel.bottom+5, width: width-100, height: emailTextlSize.height).integral
        
        // TEXT PASSWORD
        let passwordLabelize = passwordLabel.sizeThatFits(self.frame.size)
        passwordLabel.frame = CGRect(x: 50, y: emailText.bottom+20, width: self.width-100, height:passwordLabelize.height).integral
        let passwordTextlSize = passwordText.sizeThatFits(self.frame.size)
        passwordText.frame = CGRect(x:50, y: passwordLabel.bottom+5, width:self.width-100, height:passwordTextlSize.height).integral
        
        // MENSAJE ERROR LOGIN
        let messageLoginIncorrectLabelsize = messageLoginIncorrectLabel.sizeThatFits(self.frame.size)
        messageLoginIncorrectLabel.frame = CGRect(x: 50, y: passwordText.bottom+7, width: self.width-100, height: messageLoginIncorrectLabelsize.height).integral
        
        // BOTON PASSWORD OLVIDADO
        forgottenPasswordButton.frame = CGRect(x: 25, y: messageLoginIncorrectLabel.bottom+20, width: self.width-50, height: 50.0)
        
        // BOTON LOGIN
        /*loginButton.frame = CGRect(x:100, y: forgottenPasswordButton.bottom+40, width: width-200, height:50)
        loginButton.layer.cornerRadius = loginButton.height/2*/
        loginButton.frame = CGRect(x:100, y: 20, width: width-200, height:50)
        loginButton.layer.cornerRadius = loginButton.height/2
        
        // BOTON REGISTRARSE
        //createAccountButton.frame = CGRect(x:25, y:loginButton.bottom+10, width:self.width-50, height: 52.0)
        
        // BUTTON TERMS
        //termsButton.frame = CGRect(x:10, y:self.height-self.safeAreaInsets.bottom-100, width:self.width-20, height: 50)
        
        // BUTTTON PRIVACY
        //privacyButton.frame = CGRect(x:10, y:self.height-self.safeAreaInsets.bottom-50, width:self.width-20, height:50)
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
    
    func setupContainer() {
        //containerView.addSubview(profilePhotoImageView)
        //containerView.addSubview(typingCommentText)
        containerView.addSubview(loginButton)
        self.addConstraintWhithFormat(format:"H:|[v0]|",views: containerView)
        self.addConstraintWhithFormat(format:"V:[v0(100)]",views: containerView)
        bottomConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -0)
        self.addConstraint(bottomConstraint!)
    }
}
