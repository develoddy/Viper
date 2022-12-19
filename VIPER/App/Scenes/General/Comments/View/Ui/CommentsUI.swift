
import UIKit

class CommentsUI: UIView {
    
    
    var bottomConstraint: NSLayoutConstraint?
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let tableView: UITableView = {
        //let tableView = UITableView(frame: .zero, style: .grouped)
        //tableView.isHidden = false
        let tableView = UITableView()
        
        return tableView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.black
        return imageView
    }()
    
    let typingCommentText : TextFieldWithPadding = {
        let textfield = TextFieldWithPadding()
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Escribe un comentario",
            attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black ] )
        textfield.font = Constants.fontSize.regular
        textfield.backgroundColor = .systemGray6
        textfield.textColor = .black
        return textfield
    }()

    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        tableView.frame = self.bounds
        profilePhotoImageView.frame = CGRect(
            x: 10,
            y: 15,
            width: 50,
            height: 50)
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        
        typingCommentText.frame = CGRect(
            x: profilePhotoImageView.right+5,
            y: 15,
            width: self.width-profilePhotoImageView.width-30,
            height: 50)
        typingCommentText.layer.cornerRadius = typingCommentText.height/2
    }
    
    func setupView() {
        backgroundColor = .systemBackground
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
        self.addSubview(containerView)
        
    }
    
    func setupContainer() {
        containerView.addSubview(profilePhotoImageView)
        containerView.addSubview(typingCommentText)
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
    
    func configureSpinner() {
        activityIndicator.hidesWhenStopped = true
    }
}
