import UIKit

/// Comments
/// IGFeedPostDescriptionTableViewCell
class IGFeedPostGeneralTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostGeneralTableViewCell"

    private let commentTextlabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        contentView.addSubview(commentTextlabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height-4
        let labelHeight = contentView.height/2
        commentTextlabel.frame = CGRect(
             x: 10,
             y: 10,
             width: contentView.width-(size*2)-15,
             height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // SETUP COMMENTS VALUES.
    public func setCellWithValuesOf( with comment: CommentViewData ) {
        guard let username = comment.user.username else {
            return
        }
        let content = comment.content
        updateUI( username: username, content: content )
    }
    
    // UPDATE THE UI VIEWS.
    private func updateUI( username: String, content: String) {
        let attributedString = joinText(
            username: username,
            description: content )
        commentTextlabel.attributedText = attributedString
    }
    
    // JOIN TEXT
    private func joinText(username:String, description:String) -> NSMutableAttributedString {
        let boldText  = username + " "
        let attrs = [NSAttributedString.Key.font : Constants.fontSize.semibold ]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = description
        let attrs2 = [NSAttributedString.Key.font : Constants.fontSize.regular ]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        attributedString.append(normalString)
        return attributedString
    }
}
