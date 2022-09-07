
import UIKit

class CommentsUI: UIView {
    
    
    var bottomConstraint: NSLayoutConstraint?
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = false
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
    
    //var configuration = UIButton.Configuration.filled()
    
    let typingCommentText : TextFieldWithPadding = {
        let textfield = TextFieldWithPadding()
        
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Escribe un comentario",
            attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black ] )
        textfield.font = Constants.fontSize.regular
        textfield.backgroundColor = .systemGray6
        textfield.textColor = .black
       
        /*var configuration = UIButton.Configuration.filled()
        configuration = UIButton.Configuration.plain()
        configuration.title = "Public"
        configuration.baseBackgroundColor = .systemBackground
        configuration.cornerStyle = .capsule
        configuration.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { action in
          debugPrint("Download Button tapped!")
        }))
        textfield.rightView = button
        textfield.rightViewMode = .always*/
        return textfield
    }()

    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
        backgroundColor = .systemCyan
        self.addSubview(tableView)
        self.addSubview(containerView)
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
}
