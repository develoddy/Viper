//
//  IGFeedPostTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit
import SDWebImage
import AVFoundation

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    
    private var playerLayer =  AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
    }
    
    public func configure(with post: Post) {
        //self.postImageView.sd_setImage(with: URL(string: post.postImage![0].image?.src ?? ""), completed: nil)
        //self.postImageView.sd_setImage(with: URL(string: post.images?[0].src ?? ""), completed: nil)
        
        let title = post.images?[0].title ?? ""
        let url = "http://localhost:3800/api/posts/get-image-post/"+title
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = Constants.Method.httpGet
        urlRequest.setValue(Constants.headerImage.valueContentType, forHTTPHeaderField: Constants.headerImage.forHTTPHeaderFieldContenType)
        urlRequest.setValue(Constants.headerImage.valueUserAgent, forHTTPHeaderField: Constants.headerImage.forHTTPHeaderFieldUserAgent)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self?.postImageView.image = UIImage(data: data!)
                }
            } else {
                print("FAILL URL ERROR.....: \(error!.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
