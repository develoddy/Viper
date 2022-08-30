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
        loadData()
        setupView()
        configureTableView()
        configureDelegates()
        configureActivity()
        headerTableView()
        setupLeftNavItems()
        
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeUI.tableView.frame = view.bounds
        homeUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
    }
    
    // WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    /*
     - ------------ LLAMAR AL PRESENTER -------------
     - SE INCIALIZA LLAMANDO AL PRESENTER.
    */
    func loadData() {
        presenter?.viewDidLoad()
    }
    
    // SETUP VIEW
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(homeUI)
    }
    
    // TABLE HEADER
    func headerTableView() {
        homeUI.tableView.tableHeaderView = createTableHeaderView()
    }
    
    // NAV ITEMS
    func setupLeftNavItems() {
        self.navigationItem.title = "Secondary"
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

// MARK: ACCION DE BOTIENES (LIKE, COMMENT, SHARE)
extension HomeView: IGFeedPostActionsTableViewCellProtocol {
    func didTapCommentButton(model: Post) {
        print("click comentarios")
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}

// MARK: CAMBIAR A LA PANTALLA DE COMENTATIOS
extension HomeView: IGFeedPostDescriptionTableViewCellProtocol {
    func didTapComments(model: Post) {
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}
