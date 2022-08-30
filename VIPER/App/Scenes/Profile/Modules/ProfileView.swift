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

        // MARK:  PROPERTIES
        var presenter: ProfilePresenterProtocol?

        let collectionView = ProfileCollectionsViews.collectionView()

        var profileUI = ProfileUI()

        var token = Token()

        // MARK:  LIFECYCLE

        // VIEDDIDLOAD
        override func viewDidLoad() {
                super.viewDidLoad()
                loadData()
                setupView()
                configureActivity()
                configureCollectionView()
                configureCollectionViewHeader()
                configureDelegates()
        }

        // SE LLAMA AL PRESENTER
        func loadData() {
                self.presenter?.viewDidLoad()
        }

        // VIEWDIDLAYOUTSUBVIEWS
        override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                self.collectionView.frame = view.bounds
                self.profileUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        }

        // SETUPVIEW
        func setupView() {
                view.backgroundColor = .systemBackground
                self.modalPresentationStyle = .overFullScreen
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
                collectionView.register(
                        StoryFeaturedCollectionTableViewCell.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier)

                collectionView.register(
                        ProfileInfoHeaderCollectionReusableView.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)

                collectionView.register(
                        ProfileTabsCollectionReusableView.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        }

        // DELEGATES
        func configureDelegates() {
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
        }
}

// MARK: - UIABLEVIEW DATASOURCE

extension ProfileView: UICollectionViewDataSource {

        func numberOfSections(in collectionView: UICollectionView) -> Int {
                guard let numberOfSections = self.presenter?.presenterNumberOfSections() else { return 0 }
                return numberOfSections
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if section == 0 { return 0 }
            if section == 1 { return 0 }
            guard let numberOfRowInsection = self.presenter?.numberOfRowsInsection(section: section) else { return 0 }
            return numberOfRowInsection
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
                fatalError("PhotoCollectionViewCell cell not exists")
            }
            guard let post = self.presenter?.showPostsData(indexPath: indexPath) else {
                fatalError("error post")
            }
            cell.configure(with: post)
            //if self.presenter!.showPostsData().count != 0 {
                //print(self.presenter!.showPostsData())
                //cell.configure(with: self.presenter!.showPostsData())
            //}
            
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (view.frame.width / 3) - 1, height: 150)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
}

// MARK: - UIABLEVIEW FLOW LAYOUT

extension ProfileView: UICollectionViewDelegateFlowLayout {

        // MARK: Header & Story & Tabs
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
                switch indexPath.section {
                case 0:
                        let header =
                                collectionView.dequeueReusableSupplementaryView(
                                        ofKind: kind,
                                        withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                                        for: indexPath) as! ProfileInfoHeaderCollectionReusableView
                        let user = self.presenter?.username()
                        if user != nil {
                                header.configureProfile(with: user)
                        }

                        let tasts = self.presenter?.tasts()
                        if tasts != nil {
                                header.setCellWithValuesTastsOf(tasts)
                        }

                        // header.delegate = delegateHeader
                        return header
                case 1:
                        let storyHeader =
                                collectionView.dequeueReusableSupplementaryView(
                                        ofKind: kind,
                                        withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier,
                                        for: indexPath) as! StoryFeaturedCollectionTableViewCell
                        return storyHeader
                case 2:
                        let tabsHeader =
                                collectionView.dequeueReusableSupplementaryView(
                                        ofKind: kind,
                                        withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                        for: indexPath) as! ProfileTabsCollectionReusableView
                        // tabsHeader.delegate = self
                        return tabsHeader
                default:
                        break
                }

                return UICollectionReusableView()
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                if section == 0 { return CGSize(width: collectionView.width, height: collectionView.height / 2.5) }
                if section == 1 { return CGSize(width: collectionView.width, height: 90) }
                return CGSize(width: collectionView.width, height: 50)
        }
}

// MARK: - UIABLEVIEW DELEGATE

extension ProfileView: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            // SE LLAMA AL PRESENTER
            
            guard let post = self.presenter?.showPostsData(indexPath: indexPath) else { return }
            print(post)
            self.presenter?.showPost(post: post)
        }
}

// MARK:  PROFILE PROTOCOL
extension ProfileView: ProfileViewProtocol {

        // RELOAD COLLECTION
        func updateUI() {
                DispatchQueue.main.async {
                        self.collectionView.reloadData()
                }
        }

        // START ACTIVITY
        func startActivity() {
                DispatchQueue.main.async {
                        self.profileUI.activityIndicator.startAnimating()
                        UIView.animate(
                                withDuration: 0.2,
                                animations: {
                                        self.collectionView.alpha = 0.0
                                })
                }
        }

        // STOP ACTIVITY
        func stopActivity() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.profileUI.activityIndicator.stopAnimating()
                        self.profileUI.activityIndicator.hidesWhenStopped = true
                        UIView.animate(
                                withDuration: 0.2,
                                animations: {
                                        self.collectionView.alpha = 1.0
                                })
                }
        }
}

