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
        
        // COMUNICO A MI VISTA CON EL PRESENTER
        presenter?.viewDidLoad()
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeUI.tableView.frame = view.bounds
        homeUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeUI)
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
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.homeUI.activityIndicator.stopAnimating()
            self.homeUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.homeUI.tableView.alpha = 1.0
            })
        }
    }
}
