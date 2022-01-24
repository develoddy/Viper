//
//  HomeUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 18/1/22.
//

import UIKit

class HomeUI: UIView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    /*
    public let navItem : UIImageView = {
        let titleImageView = UIImageView(image: UIImage(systemName: "paperplane.fill"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        return titleImageView
    }()
    */
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        //configureSpinner()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        
        //navItem.frame = CGRect(x: 10, y: 10, width: width, height: 50)
        
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        //self.addSubview(navItem)
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }
    
    func configureSpinner() {
        activityIndicator.hidesWhenStopped = true
    }
    
    
//    func setupRemaningNavItems() -> UIImageView {
//        print("setupRemaningNavItems")
//        let titleImageView = UIImageView(image: UIImage(named: "logo"))
//        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//        titleImageView.contentMode = .scaleAspectFit
//        //self.navigationItem.titleView = titleImageView
//        return titleImageView
//    }
}
