//
//  PhotoCollectionViewCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 18/1/22.
//


import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    //let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
    
    var array_images: [Image] = []
    
    private var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        contentView.backgroundColor = .systemPink
        contentView.layer.cornerRadius = 0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        accessibilityLabel = ""
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        photoImageView.frame = contentView.bounds
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/1.5)
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        label.text = nil
    }
    
    
    // SETUP VALUES
    public func setCellWithValuesOf( with model: Post? ) {
        guard let image = model?.images?[0].title, let post = model else {
            return
        }
        updateUI(image: image, model: post)
    }
    
    // UPDATE VIEW
    func updateUI( image: String, model: Post ) {
        photoImageView.backgroundColor = .systemBackground
        let url = Constants.ApiRoutes.domain + "/api/posts/get-image-post/" + image
        self.photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.photoImageView.sd_setImage( with: URL( string: url ), completed: nil )
        label.text = model.user?.name
        
        // Updates: For UIButton use this
        // yourButton.sd_setImage(with: URL(string: urlString), for: .normal)
    }
    
}
