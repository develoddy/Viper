//
//  SearchResultView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 25/1/22.
//  
//

import Foundation
import UIKit

class SearchResultView: UIViewController {

    // MARK: - PROPERTIES
    var presenter: SearchResultPresenterProtocol?
    static weak var shared: SearchResultView?
    var searchResultUI = SearchResultUI()

    // MARK: - LIFECYCLE
    
    // VIEW LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        registerTableView()
        delegates()
        configureActivity()
    }
    
    // LAYOUT
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchResultUI.tableView.frame = view.bounds
    }
    
    // LOAD DATA
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    // SETUP
    func setupView() {
        self.view.addSubview(self.searchResultUI)
    }
    
    // REGISTER
    func registerTableView() {
        self.searchResultUI.tableView.register(SearchResultViewTableViewCell.self, forCellReuseIdentifier: SearchResultViewTableViewCell.identifier)
    }
    
    // DELEGATES
    func delegates() {
        self.searchResultUI.tableView.delegate = self
        self.searchResultUI.tableView.dataSource = self
    }
    
    // ACTIVITY
    func configureActivity() {
        self.searchResultUI.activityIndicator.center = view.center
        self.searchResultUI.activityIndicator.hidesWhenStopped = false
    }
}

// MARK: - OUT PUT
extension SearchResultView: SearchResultViewProtocol {
    func updateUI() {
        DispatchQueue.main.async {
            guard let isEmpty = self.presenter?.viewModelIsEmpty() else { return }
            self.searchResultUI.tableView.reloadData()
            self.searchResultUI.tableView.isHidden =  isEmpty // models.isEmpty
            
        }
    }
    
    // START ACTIVITY
    func startActivity() {
        DispatchQueue.main.async {
            self.searchResultUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.searchResultUI.tableView.alpha = 0.0
            })
        }
    }
    
    // STOP ACTIVITY
    func stopActivity() {
        //DispatchQueue.main.asyncAfter(deadline: .now()+2) {
        DispatchQueue.main.async {
            self.searchResultUI.activityIndicator.stopAnimating()
            self.searchResultUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.searchResultUI.tableView.alpha = 1.0
            })
        }
    }
}


// MARK: - TABLE VIEW

extension SearchResultView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewTableViewCell.identifier, for: indexPath) as! SearchResultViewTableViewCell
        guard let userpost = self.presenter?.showProfileData(indexPath: indexPath) else { return UITableViewCell() }
        cell.configure(with: userpost)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("kdssklsddskjdskjlksdkdskl")
        
        // SE LLAMA AL PRESENTER
        //guard let userPost = self.presenter?.showProfileData(indexPath: indexPath) else { return }
        //self.presenter?.showPost(userpost: userPost)
    }
}

extension SearchResultView: UITableViewDelegate {
}
