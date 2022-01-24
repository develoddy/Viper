//
//  HomeView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation
import UIKit

class HomeView: UIViewController {

    // MARK: - PROPERTIES
    var presenter: HomePresenterProtocol?
    var homeUI = HomeUI()
    let cellSpacingHeight: CGFloat = 5
    var token = Token()
    
    
    // MARK: - LIFECICLY

    // VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
        configureDelegates()
        configureActivity()
        headerTableView()
        setupLeftNavItems()
        presenter?.viewDidLoad()
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeUI.tableView.frame = view.bounds
        homeUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeUI)
    }
    
    func headerTableView() {
        homeUI.tableView.tableHeaderView = createTableHeaderView()
    }

    func setupLeftNavItems() {
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.width, height: 50))
        navigationBar.backgroundColor = .white
        navigationBar.isTranslucent = false

        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Timwider"

        // Create left and right button for navigation item
        //let leftButton =  UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(xx) )
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil)
        
        let messengerButton = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: nil)
        let chatButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)

        messengerButton.tintColor = .black
        chatButton.tintColor = .black
        profileButton.tintColor = .black
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = profileButton
        navigationItem.rightBarButtonItems = [chatButton, messengerButton]

        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
}



// MARK: - HOME VIEW PROTOCOL
extension HomeView: HomeViewProtocol {
    
    func updateUIList() {
        DispatchQueue.main.async {
            self.homeUI.tableView.reloadData()
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.homeUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.homeUI.tableView.alpha = 0.0
            })
        }
    }
    
    func stopActivity() {
        //DispatchQueue.main.asyncAfter(deadline: .now()+4) {
        DispatchQueue.main.async {
            self.homeUI.activityIndicator.stopAnimating()
            self.homeUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.homeUI.tableView.alpha = 1.0
            })
        }
    }
}

// MARK: ACTIONS
extension HomeView: IGFeedPostActionsTableViewCellProtocol {
    func didTapCommentButton(model: Userpost) {
        print("click comentarios")
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}
