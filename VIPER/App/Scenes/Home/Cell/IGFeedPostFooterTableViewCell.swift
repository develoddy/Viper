//
//  IGFeedPostFooterTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 28/4/21.
//

import UIKit


// MARK: ViewCell
class IGFeedPostFooterTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostFooterTableViewCell"
    
    //public var delegate: IGFeedPostFooterTableViewCellProtocol?
    
    private var model: Post?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    /*private let boxTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add a comment..."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        return textField
    }()*/
    
    private let boxTextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Eddy, haz un comentario...", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = Constants.fontSize.regular
        return button
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "paperplane.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .systemBackground
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(boxTextButton)
        contentView.addSubview(postButton)
        
        //boxTextButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: 40,
            height: 40)
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height / 2
        
        boxTextButton.frame = CGRect(
            x: profilePhotoImageView.right+5,
            y: 0,
            width: contentView.width-size-profilePhotoImageView.width-20,
            height: contentView.height)
        
        postButton.frame = CGRect(
            x: contentView.width-5-size,
            y: 0,
            width: size,
            height: size)
    }
    
    public func configure(with post: Post) {
        //profilePhotoImageView.sd_setImage(with: URL(string: post.userAuthor?.profile?.imageHeader ?? ""), completed: nil)
        //profilePhotoImageView.sd_setImage(with: URL(string: post.user?.profile?.imageHeader ?? ""), completed: nil)
        model = post
        
        let image = post.user?.profile?.imageHeader ?? ""
        let url = "http://localhost:3800/api/users/get-image-user/"+image
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = Constants.Method.httpGet
        urlRequest.setValue(Constants.headerImage.valueContentType, forHTTPHeaderField: Constants.headerImage.forHTTPHeaderFieldContenType)
        urlRequest.setValue(Constants.headerImage.valueUserAgent, forHTTPHeaderField: Constants.headerImage.forHTTPHeaderFieldUserAgent)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self?.profilePhotoImageView.image = UIImage(data: data!)
                }
            } else {
                print("FAILL URL ERROR.....: \(error!.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    override func prepareForReuse() {
    }
    
//    @objc private func didTapCommentButton() {
//        guard let model = model else {
//            return
//        }
//        delegate?.didTapComment(model: model)
//    }
}


extension IGFeedPostFooterTableViewCell: UITextFieldDelegate {
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let model = model else {
            return
        }
        delegate?.didTapComment(model: model)
    }*/
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let model = model else {
            return false
        }
        delegate?.didTapComment(model: model)
        return true
    }*/
}

