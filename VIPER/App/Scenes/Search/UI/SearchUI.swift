//
//  SearchUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//

import UIKit

class SearchUI: UIView {
    
    // MARK: - PROPERTIES
    let collectionView = SearchCollectionsViews.collectionView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*var navigationBar : UINavigationBar = {
        let navigation = UINavigationBar()
        return navigation
    }()*/
    
    //let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.width, height: 100))
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
        //self.navigationBar.frame = CGRect(x: 0, y: 0, width: self.width, height: 100)
    }
    
    func setupView() {
        self.addSubview(self.collectionView)
        self.addSubview(self.activityIndicator)
        //self.addSubview(self.navigationBar)
    }
}
