//
//  ProfileInfoHeaderCollectionReusableView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//

import UIKit

/*
protocol ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func profileWritePostDidTapEditProfileButton( _post:  ProfileInfoHeaderCollectionReusableView)
}
*/
final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    var stackView = UIStackView()
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    //public var delegate: ProfileReusableViewProtocol?
    
    let gradient = CAGradientLayer()
    
    ///Profile image
    private let profilePhotoImageView : UIImageView = {
        //let imageView = UIImageView(image: UIImage(named: "eddy"))
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    ///Username
    private let usernameLabel : UIButton = { //checkmark.seal.fill
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    ///PostButton
    private let postButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    ///Followers
    private let followersCountButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    ///Following
    private let followingCountButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let biographyLabel : UIButton = { //checkmark.seal.fill
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBackground
        button.titleLabel?.textColor = .black
        button.titleLabel?.textAlignment = .center
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 3
        return button
    }()
    
    ///Edit profile
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Editar tu perfil", for: .normal)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        return button
    }()
    
    private let followingButton: UIButton = {
        let followingButton = UIButton()
        followingButton.setTitle("Seguir", for: .normal)
        followingButton.backgroundColor = .systemBlue
        followingButton.layer.cornerRadius = 26
        return followingButton
    }()
    
    private let sendMessageButton: UIButton = {
        let sendMessageButton = UIButton()
        sendMessageButton.setTitle("Enviar mensaje", for: .normal)
        sendMessageButton.backgroundColor = .systemBlue
        sendMessageButton
              .layer.cornerRadius = 26
        return sendMessageButton
    }()
    
    
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        configureButtonEditProfile()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(usernameLabel)
        addSubview(postButton)
        addSubview(followersCountButton)
        addSubview(followingCountButton)
        addSubview(biographyLabel)
        addSubview(editProfileButton)
        
        addSubview(followingButton)
        addSubview(sendMessageButton)
    }
    
    private func addButtonActions() {
    //        followersCountButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
    //        followingCountButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
    //        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
    //        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    
    private func configureButtonEditProfile() {
        //gradient.colors = [UIColor(red: 0.50, green: 0.00, blue: 1.00, alpha: 1.00).cgColor, UIColor(red: 0.88, green: 0.00, blue: 1.00, alpha: 1.00).cgColor]
        gradient.colors = [UIColor(red: 0.50, green: 0.00, blue: 1.00, alpha: 1.00).cgColor, UIColor(red: 0.88, green: 0.00, blue: 1.00, alpha: 1.00).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        editProfileButton.layer.insertSublayer(gradient, at: 0)
        editProfileButton.layer.masksToBounds = true
    }
    
    func layoutsProfile() {
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: width/2.7,y: 10,width: profilePhotoSize,height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let usernameLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(
            x: 5,
            y: profilePhotoImageView.bottom+5,
            width: width-10,
            height: usernameLabelSize.height).integral
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width)/3
        
        ///Post
        postButton.frame = CGRect(
            x: 5,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Followers
        followersCountButton.frame = CGRect(
            x: postButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Following
        followingCountButton.frame = CGRect(
            x: followersCountButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Bio
        //let bioLabelSizeWidth = (width-10)/1
        let bioLabelSize = biographyLabel.sizeThatFits(frame.size)
        biographyLabel.frame = CGRect(
            x: 10,
            y: followingCountButton.bottom+10,
            width: width-20, //bioLabelSizeWidth ,
            height: bioLabelSize.height).integral
        
        ///Edit Profile
        editProfileButton.frame = CGRect(
            x: 10,
            y: biographyLabel.bottom+10,
            width: (countButtonWidth*3)-20,
            height: buttonHeight).integral
    }
    
    func layoutsUser() {
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: width/2.7,y: 10,width: profilePhotoSize,height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let usernameLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(
            x: 5,
            y: profilePhotoImageView.bottom+5,
            width: width-10,
            height: usernameLabelSize.height).integral
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width)/2
        
        ///Post
        postButton.frame = CGRect(
            x: 5,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Followers
        followersCountButton.frame = CGRect(
            x: postButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Following
        followingCountButton.frame = CGRect(
            x: followersCountButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        ///Bio
        //let bioLabelSizeWidth = (width-10)/1
        let bioLabelSize = biographyLabel.sizeThatFits(frame.size)
        biographyLabel.frame = CGRect(
            x: 10,
            y: followingCountButton.bottom+10,
            width: width-20,
            height: bioLabelSize.height).integral
        
        followingButton.frame = CGRect(
            x: 10,
            y: biographyLabel.bottom+10,
            width: countButtonWidth-10,
            height: buttonHeight).integral
        
        sendMessageButton.frame = CGRect(
            x: followingButton.right+5,
            y: biographyLabel.bottom+10,
            width: countButtonWidth-15,
            height: buttonHeight).integral
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
    override func prepareForReuse() {
        usernameLabel.setTitle(nil, for: .normal)
        biographyLabel.setTitle(nil, for: .normal)
        profilePhotoImageView.sd_setImage(with: URL(string: ""), completed: nil)
    }
    
    ///Configure
    public func configureProfile(with user: User?) {
        // Username - Image - Bio
        guard let username = user?.username,
              let image = user?.profile?.imageHeader,
              let bio = user?.profile?.bio else {
            return
        }
        profilePhotoImageView.sd_setImage(with: URL(string: image), completed: nil)
        usernameLabel.setTitle(username, for: .normal)
        biographyLabel.setTitle(bio, for: .normal)
    
        // Buttons Post - Follower - Following.
        guard let posts = user?.count?.posts,
              let follower = user?.count?.followers,
              let following = user?.count?.following else {
            return
        }
        addTextOnPostButton(posts: posts)
        addTextOnFollowersButton(follower: follower)
        addTextOnFollowingButton(following: following)
        
        layoutsProfile()
    }
    
    ///Configure
    public func configureUser(with model: User) {
        guard let image = model.profile?.imageHeader,
              let username = model.username,
              let bio = model.profile?.bio else {
            return
        }
        profilePhotoImageView.sd_setImage(with: URL(string: image), completed: nil)
        usernameLabel.setTitle(username, for: .normal)
        biographyLabel.setTitle(bio, for: .normal)
        
        ///Buttons Post - Follower - Following.
        guard let posts = model.count?.posts,
              let follower = model.count?.followers,
              let following = model.count?.following else {
            return
        }
        addTextOnPostButton(posts: posts)
        addTextOnFollowersButton(follower: follower)
        addTextOnFollowingButton(following: following)
        
        layoutsUser()
    }
    
    
    
    // MARK: - Actions
    //    @objc private func didTapFollowerButton() {
    //        delegate?.didTapFollowersButton(_header: self)
    //    }
    //    @objc private func didTapFollowingButton() {
    //        delegate?.didTapFollowingButton(_header: self)
    //    }
    //    @objc private func didTapPostsButton() {
    //        delegate?.didTapPostButton(_header: self)
    //    }
    //    @objc private func didTapEditProfileButton() {
    //        delegate?.didTapEditProfileButton(_header: self)
    //    }
    //    @objc private func didTapWritePostButton() {
    //        delegate?.didTapEditProfileButton(_post: self)
    //    }
}


//MARK: Add text on buttons
extension ProfileInfoHeaderCollectionReusableView {
    private func addTextOnPostButton(posts: Int) {
        postButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\(posts)\nPublicaciones" as NSString
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        ///label.font = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        postButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnFollowersButton(follower: Int) {
        followersCountButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\(follower) mil\nSeguidores" as NSString
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Helvetica", size: 14.0)!
        
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        followersCountButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnFollowingButton(following: Int) {
        followingCountButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\(following)\nSiguiendo" as NSString
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        let font1: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 14.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        //appending both attributed strings
        attrString1.append(attrString2)
        followingCountButton.setAttributedTitle(attrString1, for: [])
    }
}

