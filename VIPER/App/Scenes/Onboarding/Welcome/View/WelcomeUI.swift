import UIKit

// MARK: UI
class WelcomeUI: UIView {
    
    let gradient = CAGradientLayer()
    var bottomConstraint: NSLayoutConstraint?
    
    public let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray6
        return headerView
    }()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "VIPER"
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = Constants.Color.black
        return label
    }()

    public let logInButton : LoadingButton = {
        let button = LoadingButton()
        button.setTitle("Iniciar sesión", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = Constants.Color.primary
        return button
    }()
    
    public let signUpButton : LoadingButton = {
        let button = LoadingButton()
        button.setTitle("Registrarse", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemGray6
        button.layer.borderColor = Constants.Color.secondary.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(Constants.Color.secondary, for: .normal)
        return button
    }()
   
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContainer()
        configureHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(containerView)
        self.addSubview(headerView)
    }
    
    override func layoutSubviews() {
        // HEADER
        headerView.frame = CGRect(x: 0,y: 0.0,width: self.width,height: self.height/2)
        
        // LOGO
        let size = headerView.height/3
        logoImageView.frame = CGRect(x: (self.width-size)/2, y:(headerView.height-size)/2, width:size, height: size)
        logoImageView.layer.cornerRadius = logoImageView.height/2
        
        // TITLE
        titleLabel.frame = CGRect(x:10, y:logoImageView.bottom+40, width: width-20, height:30)
        
        logInButton.frame = CGRect(x:20, y: 20, width: width-40, height:60)
        logInButton.layer.cornerRadius = logInButton.height/2
        
        signUpButton.frame = CGRect(x:20, y: logInButton.bottom+8, width: width-40, height:60)
        signUpButton.layer.cornerRadius = signUpButton.height/2
    }
    
    // HEADER VIEW
    func configureHeaderView() {
        // COLOR HEADER
        headerView.clipsToBounds = true
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBackground.cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = self.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        
        // LOGO
        logoImageView.backgroundColor = .systemGray6
        logoImageView.layer.masksToBounds = true
        
        // ADD LOGO & TITLE
        headerView.addSubview(logoImageView)
        headerView.addSubview(titleLabel)
    }
    
    func setupContainer() {
        containerView.addSubview(logInButton)
        containerView.addSubview(signUpButton)
        
        self.addConstraintWhithFormat(format:"H:|[v0]|",views: containerView)
        self.addConstraintWhithFormat(format:"V:[v0(200)]",views: containerView)
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
