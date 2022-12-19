//
//  ProfileTabsCollectionReusableView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//

import UIKit

protocol ProfileTabsCollectionReusableViewProtocol: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView:  UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableViewProtocol"
    
    public var delegate: ProfileTabsCollectionReusableViewProtocol?
    
    private let gridButton: UIButton = {
        let button  = UIButton()
        button.clipsToBounds = true
        button.tintColor = .darkGray
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
        
    private let taggedButton: UIButton = {
        let button  = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        acctionButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    
    func acctionButtons() {
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size =  height - (Constants.ProfileTabsCollectionReusableViewColor.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constants.ProfileTabsCollectionReusableViewColor.padding,
                                    width: size,
                                    height: size)
        taggedButton.frame = CGRect(x: gridButtonX + (width/2),
                                    y: Constants.ProfileTabsCollectionReusableViewColor.padding,
                                    width: size,
                                    height: size)
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .black
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton() {
        taggedButton.tintColor = .black
        gridButton.tintColor = .lightGray
        delegate?.didTapTaggedButtonTab()
    }
}

///Simula la carga para mostrar datos en el profileViewcontroller
class ProfileTabsCollectionReusableView2:  UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView2"
    private let gridButton: UIButton = {
        let button  = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size =  height - (Constants.ProfileTabsCollectionReusableViewColor.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constants.ProfileTabsCollectionReusableViewColor.padding,
                                    width: size,
                                    height: size)
    }
}
