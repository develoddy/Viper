//
//  ProfileInfoHeaderCollectionReusableView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//

import UIKit
import SDWebImage

protocol ProfileInfoHeaderCollectionReusableViewProtocol {
    func didTapFollowersButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func didTapFollowingButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func didTapEditProfileButton( _header:  ProfileInfoHeaderCollectionReusableView)
    // func profileHeaderDidTapPostButton( _header:  ProfileInfoHeaderCollectionReusableView)
    // func profileWritePostDidTapEditProfileButton( _post:  ProfileInfoHeaderCollectionReusableView)
}


final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    // PROPERTIES
    var stackView = UIStackView()
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public var delegate: ProfileInfoHeaderCollectionReusableViewProtocol?
    let gradient = CAGradientLayer()
    var model: UserViewData? //User?
    
   
    public let profilePhotoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
   
    private let usernameLabel : UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        button.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
   
    private let postButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersCountButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
   
    private let followingCountButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .thin)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let biographyLabel : UIButton = {
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
    
    // TODO: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        configureButtonEditProfile()
        layoutsProfile()
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
        followersCountButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingCountButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        // postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
    }
    
    
    private func configureButtonEditProfile() {
        gradient.colors = [ UIColor( red: 0.50, green: 0.00, blue: 1.00, alpha: 1.00 ).cgColor,
                            UIColor( red: 0.88, green: 0.00, blue: 1.00, alpha: 1.00 ).cgColor ]
        gradient.startPoint = CGPoint( x: 0, y: 1 )
        gradient.endPoint = CGPoint( x: 1, y: 1 )
        editProfileButton.layer.insertSublayer( gradient, at: 0 )
        editProfileButton.layer.masksToBounds = true
    }
    
    func layoutsProfile() {
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: width/2.7,
            y: 10,
            width: profilePhotoSize,
            height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let usernameLabelSize = usernameLabel.sizeThatFits( frame.size )
        usernameLabel.frame = CGRect(
            x: 5,
            y: profilePhotoImageView.bottom+5,
            width: width-10,
            height: usernameLabelSize.height).integral
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = ( width )/3
        
        postButton.frame = CGRect(
            x: 5,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followersCountButton.frame = CGRect(
            x: postButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingCountButton.frame = CGRect(
            x: followersCountButton.right,
            y: usernameLabel.bottom+5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        let bioLabelSize = biographyLabel.sizeThatFits( frame.size )
        biographyLabel.frame = CGRect(
            x: 10,
            y: followingCountButton.bottom+10,
            width: width-20,
            height: bioLabelSize.height ).integral

        editProfileButton.frame = CGRect(
            x: 10,
            y: biographyLabel.bottom+10,
            width: ( countButtonWidth*3 ) - 20,
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
    
    // CONFIGURE PROFILE
    public func configureProfile(with user: UserViewData? /*User?*/) {
        self.model = user
        guard let username  = user?.username,
              let image     = user?.imageHeader,
              let bio       = user?.bio else {
            return
        }
        
        let url = Constants.ApiRoutes.domain + "/api/users/get-image-user/" + image
        profilePhotoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        profilePhotoImageView.sd_setImage( with: URL( string: url ), completed: nil )
        usernameLabel.setTitle( username, for: .normal )
        biographyLabel.setTitle( bio, for: .normal )
    }
    
    // SETUP VALUES
    public func setCellWithValuesTastsOf( _ modelTast: ResCounter? ) {
        guard let following = modelTast?.following,
              let followed = modelTast?.followed,
              let posts = modelTast?.posts else {
            return
        }
        updateUI(following: following, followed: followed, posts: posts)
    }
    
    // UPDATE UI
    private func updateUI(following: Int, followed: Int, posts: Int) {
        addTextOnFollowingButton(following: following)
        addTextOnFollowersButton(follower: followed)
        addTextOnPostButton(posts: posts)
    }
 
}


// TODO: ACTION BUTTONS.
extension ProfileInfoHeaderCollectionReusableView {
    @objc private func didTapFollowerButton() {
        delegate?.didTapFollowersButton(_header: self)
    }
    @objc private func didTapFollowingButton() {
        delegate?.didTapFollowingButton(_header: self)
    }

    @objc private func didTapEditProfileButton() {
        delegate?.didTapEditProfileButton(_header: self)
    }
}


// TODO: ADD TEXT ON BUTTONS.
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

