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

    // MARK: - Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var presenter: HomePresenterProtocol?

    
    // MARK: - Lifecycle

    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // COMUNICO A MI VISTE CON EL PRESENTER
        presenter?.viewDidLoad()
        
        // Setup
        setupView()
    }
    
    // ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupView() {
        view.backgroundColor = .systemRed
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}



// MARK: - A conformance to tableView delegate and datasource protocols
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = "Text"
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
    }
}


// MARK: - A conformance to HomeViewProtocol protocol
extension HomeView: HomeViewProtocol {
    // TODO: implement view output methods
}
