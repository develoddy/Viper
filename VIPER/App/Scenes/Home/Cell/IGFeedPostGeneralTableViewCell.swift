//
//  IGFeedPostGeneralTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit

/// Comments
/// IGFeedPostDescriptionTableViewCell
class IGFeedPostGeneralTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostGeneralTableViewCell"

    private let hourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hourLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelTextCommentSize = hourLabel.sizeThatFits(frame.size)
        hourLabel.frame = CGRect(x: 15,y: 9,width: contentView.width-5,height: labelTextCommentSize.height).integral
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
    }
    
    //public func configure(with model: Comment)  {
    public func configure(with count: Int) {
        hourLabel.text = "HACE 12 HORAS"
    }
    
}

