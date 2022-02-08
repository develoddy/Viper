//
//  PostUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//

import UIKit

class PostUI: UIView {
    
    // MARK: PROPERTIES
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
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
    
    // MARK: FUNCTIONS
    override func layoutSubviews() {
    }
    
    private func setupView() {
        backgroundColor = .white
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }
    
    func configureSpinner() {
        activityIndicator.hidesWhenStopped = true
    }

}
