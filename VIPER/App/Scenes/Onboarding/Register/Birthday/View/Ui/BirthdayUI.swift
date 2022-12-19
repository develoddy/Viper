import UIKit

class BirthdayUI: UIView {
    
    let gradient = CAGradientLayer()
    var bottomConstraint: NSLayoutConstraint?
    
    public let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "¿Cuando es tu cumpleaños?"
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = Constants.Color.black
        return label
    }()
        
    public let birthdayLabel : UILabel = {
        let label = UILabel()
        label.text = "FECHA DE CUMPLEAÑOS"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Constants.Color.gray
        return label
    }()
    
    public let birthdayText : TextFieldWithPadding = {
        let emailText = TextFieldWithPadding()
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
    
    public let continueButton : LoadingButton = {
        let button = LoadingButton()
        button.setTitle("Siguiente", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = Constants.Color.cyan
        return button
    }()

    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureHeaderView()
        configureFooterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // HEADER
        headerView.frame = CGRect(x: 0,y: 0.0,width: self.width,height: self.height/2)
        
        // TITLE
        let size = headerView.height/3
        titleLabel.frame = CGRect(x:10, y:(headerView.height-size)/2, width: width-20, height:30)
        
        // FECHA CUMPLEAÑOS
        let birthdayLabelSize = birthdayLabel.sizeThatFits(self.frame.size)
        birthdayLabel.frame = CGRect(x: 50, y: titleLabel.bottom+40, width: width-100, height: birthdayLabelSize.height).integral
        let birthdayTextSize = birthdayText.sizeThatFits(self.frame.size)
        birthdayText.frame = CGRect(x: 50, y: birthdayLabel.bottom+5, width: width-100, height: birthdayTextSize.height).integral
        
        // BOTON SIGUIENTE
        continueButton.frame = CGRect(x:100, y: 20, width: width-200, height:50)
        continueButton.layer.cornerRadius = continueButton.height/2
    }
    
    private func setupView() {
        self.addSubview(headerView)
        self.addSubview(footerView)
    }
    
    func configureHeaderView() {
        headerView.clipsToBounds = true
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBackground.cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = self.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        
        // ADD
        headerView.addSubview(titleLabel)
        headerView.addSubview(birthdayLabel)
        headerView.addSubview(birthdayText)
    }
    
    func configureFooterView() {
        self.addConstraintWhithFormat(format:"H:|[v0]|",views: footerView)
        self.addConstraintWhithFormat(format:"V:[v0(100)]",views: footerView)
        bottomConstraint = NSLayoutConstraint(
            item: footerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -0)
        self.addConstraint(bottomConstraint!)
        
        // ADD
        footerView.addSubview(continueButton)
    }
}
