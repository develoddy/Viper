import UIKit

struct SheePostFormModel:Hashable {
    let iconImage: String
    let label: String
}


protocol  SheePostTableViewCellProtocol {
    func formTableViewCell( _ cell: SheePostTableViewCell, didUpdateField updateModel: SheePostFormModel )
}


class SheePostTableViewCell: UITableViewCell {

    // MARK: PORPERTIES
    static let identifier = "SheePostTableViewCell"
    private var model: SheePostFormModel?
    //public var delegate: SheeHomePostsTableViewCellProtocol?
    
    // MARK: ELEMENTS
    private let iconUIImageView: UIImageView = {
        let iconUIImageView = UIImageView()
        iconUIImageView.tintColor = .black
        return iconUIImageView
    }()
    
    private let label: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .label
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.Color.lightDark
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        clipsToBounds = true
        contentView.addSubview(iconUIImageView)
        contentView.addSubview(label)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconUIImageView.frame = CGRect(
            x: 20,
            y: 10,
            width: contentView.height / 2,
            height: contentView.height / 2)
        iconUIImageView.layer.cornerRadius = iconUIImageView.height / 2
        
        label.frame = CGRect(
            x: iconUIImageView.right+15,
            y: 0,
            width: contentView.width-20-iconUIImageView.width,
            height: contentView.height )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconUIImageView.image = nil
        self.label.text = nil
    }
    
    // SETUP VALUES
    public func setCellWithValuesOf( with model: SheePostFormModel? ) {
        self.model = model
        guard let iconImage = model?.iconImage,
              let label = model?.label else {
            return
        }
        updateUI(iconImage: iconImage, label: label)
    }
    
    // UPDATE VIEW
    func updateUI(iconImage: String, label: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        self.iconUIImageView.image = UIImage(systemName: iconImage, withConfiguration: config)
        self.label.text = label
    }
}
