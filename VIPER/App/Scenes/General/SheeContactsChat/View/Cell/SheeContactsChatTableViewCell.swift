
import UIKit

struct SheeContactsChatFormModel:Hashable {
    let iconImage: String
    let label: String
    let userId: Int
}

class SheeContactsChatTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES
    static let identifier = "SheeContactsChatTableViewCell"
    private var model: SheeContactsChatFormModel?
    
    // MARK: ELEMENTS
    private let iconUIImageView: UIImageView = {
        let iconUIImageView = UIImageView()
        iconUIImageView.tintColor = Constants.Color.grayDark
        return iconUIImageView
    }()
    
    private let label: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = Constants.Color.grayDark
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
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
    public func setCellWithValuesOf( with model: SheeContactsChatFormModel? ) {
        self.model = model
        guard let iconImage = model?.iconImage,
              let label = model?.label else {
            return
        }
        updateUI(iconImage: iconImage, label: label)
    }
    
    // UPDATE VIEW
    func updateUI(iconImage: String, label: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        self.iconUIImageView.image = UIImage(systemName: iconImage, withConfiguration: config)
        self.label.text = label
    }
}
