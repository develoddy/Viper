//
//  ProfileView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation
import UIKit

class ProfileView: UIViewController {

    // MARK: - PROPERTIES
    var presenter: ProfilePresenterProtocol?
    let collectionView = ProfileCollectionsViews.collectionView()
    var profileUI = ProfileUI()
    var token = Token()
    // var email: String = ""

    // MARK: - INIT
    //    init(with email: String) {
    //        super.init(nibName: nil, bundle: nil)
    //        self.email = email
    //    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - LIFECYCLE
    
    // VIEDDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureActivity()
        configureCollectionViewHeader()
        configureCollectionView()
        
        configureDelegates()
        
        // MARK: SE LLAMA AL PRESENTER
        guard let token = token.getUserToken().token else { return }
        self.presenter?.viewDidLoad(email: "eddylujann@gmail.com", token: token)
    }
    
    // VIEWDIDLAYOUTSUBVIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = view.bounds
        self.profileUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    // SETUPVIEW
    func setupView() {
        title = "Profile"
        view.backgroundColor = .systemPink
        view.addSubview(profileUI)
        view.addSubview(collectionView)
    }
    
    // ACTIVITY
    func configureActivity() {
        profileUI.activityIndicator.center = view.center
        profileUI.activityIndicator.hidesWhenStopped = false
    }
    
    // COLLECTION
    func configureCollectionView() {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    // COLLECTION HEADER
    func configureCollectionViewHeader() {
        collectionView.register(StoryFeaturedCollectionTableViewCell.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:
                                    StoryFeaturedCollectionTableViewCell.identifier)
        
        collectionView.register(ProfileInfoHeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
    }
    
    // DELEGATES
    func configureDelegates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}




//MARK: - UITABLEVIEWS

//MARK: DATASOURCE
extension ProfileView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //print(presenter?.presenterNumberOfSections() ?? 0)
        guard let count = presenter?.presenterNumberOfSections() else {
            return 0
        }
        return count //presenter?.presenterNumberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        if section == 1 { return 0 }
       
        guard let count = presenter?.numberOfRowsInsection(section: section) else {
            return 0
        }
        print(count)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collection ejecuta")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell cell not exists")
        }
        guard let model = presenter?.cellForRowAt(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(view.frame.width/3)-1, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    // MARK: Header & Story & Tabs
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        print("collection header ejecuta")
       
        
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        switch indexPath.section {
        case 0:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier:ProfileInfoHeaderCollectionReusableView.identifier,
                                                                         for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            //let user = presenter?.fetchUsername(indexPath: indexPath)
            //print(user)
            
            //print(user)
            //header.configureProfile(with: user)
            ///header.delegate = delegateHeader
            return header
        case 1:
            let storyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                              withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,
                                                                              for: indexPath) as! StoryFeaturedCollectionTableViewCell
            return storyHeader
        case 2:
            let tabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                             for: indexPath) as! ProfileTabsCollectionReusableView
            //tabsHeader.delegate = self
            return tabsHeader
        default:
            break
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize(width: collectionView.width, height: collectionView.height/2.5) }
        if section == 1 { return CGSize(width: collectionView.width, height: 90) }
        return CGSize(width: collectionView.width, height: 50)
    }
}




// MARK: DELEGATE
extension ProfileView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        ///delegate.itemSelected(indexPath: indexPath)
    }
}



// MARK: - PROFILE PROTOCOL
extension ProfileView: ProfileViewProtocol {
    
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // START ACTIVITY
    func startActivity() {
        DispatchQueue.main.async {
            self.profileUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.collectionView.alpha = 0.0
            })
        }
    }
    
    // STOP ACTIVITY
    func stopActivity() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.profileUI.activityIndicator.stopAnimating()
            self.profileUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.alpha = 1.0
            })
        }
    }
}
