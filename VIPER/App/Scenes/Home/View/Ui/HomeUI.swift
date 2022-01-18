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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        
    }
    
    private func setupView() {
        backgroundColor = .systemRed
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }
    
    func configureSpinner() {
        activityIndicator.hidesWhenStopped = false
    }
}
