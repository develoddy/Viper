import UIKit

struct EditProfileFormModel {
    let label: String
    let placeHolder: String
    var value: String?
}

protocol  FormTableViewCellProtocol {
    func formTableViewCell( _ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel )
}

class FormTableViewCell: UITableViewCell {
    
    // PROPERTIES.
    static let identifier = "FormTableViewCell"
    private var model: EditProfileFormModel?
    public var delegate: FormTableViewCellProtocol?
    
    // ELEMENTS.
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(
            x: 5,
            y: 0,
            width: contentView.width/3,
            height: contentView.height )
        field.frame = CGRect(
            x: formLabel.right+5,
            y: 0,
            width: contentView.width-10-formLabel.width,
            height: contentView.height )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.formLabel.text = nil
        self.field.placeholder = nil
        self.field.text = nil
    }
    
    // SETUP VALUES
    public func setCellWithValuesOf( with model: EditProfileFormModel? ) {
        self.model = model
        
        guard let labelText         = model?.label      ,
              let placeHolderText   = model?.placeHolder,
              let valueText         = model?.placeHolder else {
            return
        }
        updateUI(text: labelText, placeHolder: placeHolderText, field: valueText)
    }
    
    // UPDATE VIEW
    func updateUI(text: String, placeHolder: String, field: String ) {
        self.formLabel.text     = text
        self.field.placeholder  = placeHolder
        self.field.text         = field
    }
}

// MARK: FIELD
extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn( _ textField: UITextField ) -> Bool {
        
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell( self, didUpdateField: model )
        textField.resignFirstResponder()
        return true
    }
}
