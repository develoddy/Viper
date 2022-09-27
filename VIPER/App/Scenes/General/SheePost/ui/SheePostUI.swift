//
//  SheePostUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/9/22.
//

import UIKit

class SheePostUI: UIView {
    
    var bottomConstraint: NSLayoutConstraint?
    
    public let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        //let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        
        return tableView
    }()
    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
    }
    
    private func setupView() {
        backgroundColor = .white
        self.addSubview(tableView)
    }
    
}
