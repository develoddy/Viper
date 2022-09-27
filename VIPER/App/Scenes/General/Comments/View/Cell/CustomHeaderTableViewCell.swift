import UIKit
import SDWebImage

class CustomHeaderTableViewCell: UITableViewCell {

    static let identifier = "CustomHeaderTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.tintColor = .black
        return imageView
    }()
    
    private let commentlabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let timeToPostCommentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "1h"
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(userImageView)
        contentView.addSubview(commentlabel)
        contentView.addSubview(timeToPostCommentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        ///margin
        let size = contentView.height-4
        userImageView.frame = CGRect(
            x       : 5,
            y       : 10,
            width   : contentView.height/2,
            height  : contentView.height/2)
        userImageView.layer.cornerRadius = userImageView.height/2
        
        ///Hay que ver si el texto de la publicacion es de longitud grande para generar la altura dinamicamente
        let labelHeight = contentView.height/1.5
        ///commentlabel.backgroundColor = .systemRed
        commentlabel.frame = CGRect(
             x      : userImageView.right+5,
             y      : 10,
             width  : contentView.width-(size*1)-15,
            height  : contentView.height-25-timeToPostCommentLabel.height )
        
        let  buttonSubLabelWidth = contentView.width > 100 ? 280.0 : contentView.width/3
        ///timeToPostCommentLabel.backgroundColor = .systemBlue
        timeToPostCommentLabel.frame = CGRect(
            x       : userImageView.right+5,
            y       : commentlabel.bottom,
            width   : contentView.width-8-userImageView.width-buttonSubLabelWidth,
            height  : labelHeight/2.5 ) //labelHeight/2.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func joinText(username:String, description:String) -> NSMutableAttributedString {
        // Username
        let boldText  = username + " "
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        // Commentario
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: CGFloat(14))]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
    
    // SETUP POSTS VALUES.
    public func setCellWithValuesOf(with post: PostViewData?) {
        guard let username = post?.user.username, let content = post?.content, let image = post?.user.profile?.imageHeader else {
            return
        }
        updateUI(username: username, content: content, image: image)
    }
    
    // UPDATE TE UI VIEWS.
    func updateUI(username: String, content: String, image: String) {
        let attributedString = joinText(username: username, description: content)
        commentlabel.attributedText = attributedString
        let url = Constants.ApiRoutes.domain + "/api/users/get-image-user/" + image
        userImageView.sd_setImage(with: URL(string: url), completed: nil)
    }
}
