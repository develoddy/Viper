//
//  ProfileUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 18/1/22.
//

import UIKit

class ProfileUI : UIView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        
    }
    
    func setupView() {
        backgroundColor = .systemCyan
        self.addSubview(activityIndicator)
    }
}
