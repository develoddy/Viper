//
//  SearchView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit

class SearchView: UIViewController {

    // MARK: Properties
    var presenter: SearchPresenterProtocol?
    var searchUI = SearchUI()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        registerCollection()
        delegates()
    }
    
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        self.view.addSubview(searchUI)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchUI.frame = view.bounds
    }
    
    func registerCollection() {
        
    }
    
    func delegates() {
        
    }
}


extension SearchView: SearchViewProtocol {
    // TODO: implement view output methods
}
