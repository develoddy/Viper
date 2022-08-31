//
//  PostView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/2/22.
//  
//

import Foundation
import UIKit

class PostView: UIViewController {

    // MARK: PROPERTIES
    var presenter: PostPresenterProtocol?
    var postUI = PostUI()

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        configureTableView()
        configureDelegates()
    }
    
    // VIEWDIDLAYOUTSUBVIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.postUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        self.postUI.tableView.frame = view.bounds
    }
    
    // SE LLAMA AL PRESENTER
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    // SETUPVIEW
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(postUI)
    }
    
    func configureTableView() {
        postUI.tableView.backgroundColor = .secondarySystemFill
        postUI.tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        postUI.tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        postUI.tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        postUI.tableView.register(IGFeedPostDescriptionTableViewCell.self, forCellReuseIdentifier: IGFeedPostDescriptionTableViewCell.identifier)
        postUI.tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        postUI.tableView.register(IGFeedPostFooterTableViewCell.self, forCellReuseIdentifier: IGFeedPostFooterTableViewCell.identifier)
        postUI.tableView.separatorStyle = .none
    }
    
    func configureDelegates() {
        postUI.tableView.delegate = self
        postUI.tableView.dataSource = self
    }
}

extension PostView: PostViewProtocol {
    // TODO: implement view output methods
}




// MARK: - UITABLE VIEW DATASOURCE

extension PostView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.presenterNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = self.presenter?.cellForRowAt( at: indexPath ) else {
            return UITableViewCell()
        }
        
        switch model.renderType {
            case .actions(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                let comment = comments[indexPath.row]
                cell.setCellWithValuesOf(with: comment)
                return cell
            
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            
            case .header(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: post)
                // cell.delegate = self
                return cell
            
            case .descriptions(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
                cell.setCellWithValuesOf(post)
                //cell.delegate = self
                return cell
            
            case .footer(let footer):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
                cell.configure(with: footer)
                // cell.delegate = self
                return cell
        }
        
    }
}



// MARK: - UITABLE VIEW DELEGATE

extension PostView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = self.presenter?.cellForRowAt(at: indexPath) else { return CGFloat() }
            switch model.renderType {
            case .actions(_)        : return 40 // ACTION
            case .comments(_)       : return 30 // COMMENT
            case .primaryContent(_) : return tableView.width // POST
            case .header(_)         : return 70 // HEADER
            case .descriptions(_)   : return 85 // DESCRIPTION
            case .footer(_)         : return 50 // FOOTER
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
