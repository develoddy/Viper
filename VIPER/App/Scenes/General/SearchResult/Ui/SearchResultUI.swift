//
//  SearchResultUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//

import UIKit

class SearchResultUI: UIView {
    
    // MARK: - PROPERTIES
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.isHidden = true
        return tableView
    }()

    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = CGRect(x: self.tableView.width/2, y: 100, width: self.width, height: 100)
    }
    
    func setupView() {
        self.backgroundColor = .systemPink
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }
}
