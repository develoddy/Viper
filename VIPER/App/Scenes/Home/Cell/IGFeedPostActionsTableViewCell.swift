//
//  IGFeedPostActionsTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit


class HeartButton: UIButton {
    private var isLiked = false
    private let unlikedImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
    private let likedImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
 
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3

    override public init(frame: CGRect) {
        super.init(frame: frame)
    
        setImage(unlikedImage, for: .normal)
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func flipLikedState() -> Bool {
        isLiked = !isLiked
        animate()
        return isLiked
    }

    private func animate() {
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? self.likedImage : self.unlikedImage
            let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.transform = self.transform.scaledBy(x: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
}







// MARK: Protocol
protocol IGFeedPostActionsTableViewCellProtocol: AnyObject {
    func didTapLikeButton(_ sender: HeartButton, model: Post)
    //func didTapCommentButton(model: UserpostViewModel)
    func didTapCommentButton(model: Post)
    //func didTapSendButton()
}




// MARK: CELL
class IGFeedPostActionsTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    public var delegate: IGFeedPostActionsTableViewCellProtocol?
    
    private var model: Post?
    
    private var isLiked = false
    
    private var idUser = 0
    
    /*private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()*/
    
    private let likeButton: HeartButton = {
        let likeButton = HeartButton()
        likeButton.layer.masksToBounds = true
        return likeButton
    }()
 
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "message", withConfiguration: config) ///message
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: config) ///paperplane
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "bookmark", withConfiguration: config) ///paperplane
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        setupView()
        setupActionButtons()
    }
    
    private func setupView() {
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(bookmarkButton)
    }
    
    private func setupActionButtons() {
        commentButton.addTarget(self, action: #selector(didTapCommetnButton), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleHeartButtonTap(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height-10
        let buttons = [likeButton, commentButton, sendButton ]
    
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.contentHorizontalAlignment = .left
            
            button.frame = CGRect(
                x: (CGFloat(x)*buttonSize)+(10*CGFloat(x+1)),
                y: 5,
                width: buttonSize,
                height: buttonSize)
        }
        bookmarkButton.frame = CGRect(
            x: contentView.width-buttonSize-15,
            y: 5,
            width: buttonSize,
            height: buttonSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.setImage(nil, for: .normal)
    }
    
    // SETUP VALUES
    public func setCellWithValuesOf(_ model: Post, identity: UserLogin?) {
        self.model = model
        
        guard let identity = identity, let heart = model.hearts else {
            return
        }
        self.updateUI(heart: heart, identity: identity)
    }
    
    // UPDATE UI
    func updateUI(heart: [Heart], identity:UserLogin) {
        
        // SI EL USUARIO CONECTADO SE ENCUENTRA EN EL ARRAY DE LIKES.
        // SI SE ENCUENTRA ENTONCES ACTIVAMOS EL BOTON DE LIKES EN COLOR ROJO.
        let filter = heart.firstIndex(where: {$0.userID == identity.id})
        if filter != nil {
            let _ = likeButton.flipLikedState()
        }
        
        //let _ = likeButton.flipLikedState()
    }
    
    // DIPTAP BUTTONS
    @objc private func didTapCommetnButton() {
        guard let model = model else {
            return
        }
        
        delegate?.didTapCommentButton(model: model)
    }
    
    
    @objc private func handleHeartButtonTap(_ sender: UIButton) {
        guard let model = model else {
            return
        }
        guard let button = sender as? HeartButton else { return }
        delegate?.didTapLikeButton(button, model: model)
        
        //guard let button = sender as? HeartButton else { return }
        //button.flipLikedState()
    }
}



//MARK: BUTTONS
extension IGFeedPostActionsTableViewCell {
    
    
    private func addTextOnCommentButton() {
        commentButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\n5" // 10\nPost
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
        commentButton.setAttributedTitle(attrString1, for: [])
    }
    
    private func addTextOnShareButton() {
        let buttonText: NSString = "\n10" // 10\nPost
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
    }
    
    private func addTextOnSendButton() {
        sendButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let buttonText: NSString = "\nSend" // 10\nPost
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
        sendButton.setAttributedTitle(attrString1, for: [])
    }
}

