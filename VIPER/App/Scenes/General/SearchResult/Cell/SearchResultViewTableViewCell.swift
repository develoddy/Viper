//
//  SearchResultViewTableViewCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//


import UIKit

class SearchResultViewTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultViewTableViewCell"
    
    private let superView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.7
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "user4")
        imageView.backgroundColor = .systemGray4
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        //label.text = "@Joe"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowshape.turn.up.right.fill") // arrow.forward
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(superView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        superView.frame = CGRect(
            x: 5,
            y: 10,
            width: contentView.height-15,
            height: contentView.height-15)
        superView.layer.cornerRadius = superView.height/2
        superView.addSubview(profileImageView)
        
        profileImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.height-15,
            height: contentView.height-15)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size: CGFloat = 30
        let labelHeight = contentView.height/3
        //usernameLabel.backgroundColor = .green
        usernameLabel.frame = CGRect(
            x: superView.right+5,
            y: 10,
            width: contentView.width-size-superView.width-16,
            height: labelHeight)
        
        fullNameLabel.frame = CGRect(
            x: superView.right+5,
            y: usernameLabel.bottom,
            width: contentView.width-size-superView.width-16,
            height: labelHeight)
        
        let buttonHeight: CGFloat = 40
        arrowImage.frame = CGRect(
            x: contentView.width-5-size,
            y: (contentView.height-buttonHeight)/2,
            width: contentView.height-40,
            height: contentView.height-40)
        //arrowImage.backgroundColor = .red
        arrowImage.layer.cornerRadius = superView.height/5
    }
    
    public func configure(with model: User ) {
        guard let image = model.profile?.imageHeader else {return}
        guard let username = model.username else { return }
        guard let name = model.name else { return }
        
        let url = "http://localhost:3800/api/users/get-image-user/" + image
        profileImageView.sd_setImage(with: URL(string: url), completed: nil)
        usernameLabel.text = username
        fullNameLabel.text = name
    }
}

