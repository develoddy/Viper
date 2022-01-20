//
//  StoryCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 6/10/21.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
     
    static let identifier = "StoryCollectionViewCell"
    
    let storybutton = UIButton()
    let usernameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupview()
        configureStoryButtom()
        configureUsernameLabel()
    }
    
    private func setupview() {
        contentView.addSubview(storybutton)
        contentView.addSubview(usernameLabel)
    }
    
    private func configureStoryButtom() {
        //storybutton.setImage(UIImage(named: "eddy"), for: .normal)
        storybutton.backgroundColor = .systemYellow
        storybutton.layer.masksToBounds = true
        storybutton.frame = storybutton.bounds
    }
    
    private func configureUsernameLabel() {
        //usernameLabel.text = "eddylujann"
        usernameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        usernameLabel.backgroundColor = .systemBackground
        usernameLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //let center = contentView.frame.size.width/5
        storybutton.frame = CGRect(x: 10, y:5, width:60, height: 60)
        storybutton.layer.cornerRadius = storybutton.height/2
        
        let usernameLabelLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(x: 0, y: storybutton.bottom+5, width:  contentView.width, height: usernameLabelLabelSize.height).integral
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(model: Storyfeatured) {
        ///Recive las images que iran pintadas en el sototy featured
        guard let image = model.src else {
            return
        }
        guard let title = model.title else {
            return
        }
        storybutton.sd_setImage(with: URL(string: image), for: .normal, completed: nil)
        usernameLabel.text = title
    }
}

