//
//  TextFieldWithPadding.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 20/1/22.
//

import UIKit
class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 0,
        bottom: 5,
        right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    private let underline = CALayer()
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        setupUnderline()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 35.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPadding()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addPadding()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addPadding()
        setupUnderline()
    }
    
    private func addPadding() {
        // 1
        rightViewMode = .always
        leftViewMode = .always

        // 2
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 12,
                height: 35
            )
        )

        // 3
        leftView = paddingView
        rightView = paddingView
    }
    
    
    private func setupUnderline() {
        // 1
        borderStyle = .none
            
        // 2
        let lineWidth: CGFloat = 1.0
        underline.borderColor = UIColor.systemGray4.cgColor //UIColor(red: 0.10, green: 0.11, blue: 0.16, alpha: 1.00).cgColor
        underline.frame = CGRect(
            x: 0,
            y: frame.size.height - lineWidth,
            width: frame.size.width,
            height: frame.size.height
        )
        underline.borderWidth = lineWidth
            
        // 3
        layer.addSublayer(underline)
        layer.masksToBounds = true
    }
}

