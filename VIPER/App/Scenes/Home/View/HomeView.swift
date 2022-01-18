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

    // MARK:  Properties
    var presenter: HomePresenterProtocol?
    //var viewModel = [HomeFeedRenderViewModel]()
    var homeUI = HomeUI()
    let cellSpacingHeight: CGFloat = 5
    
    
    
    // MARK: - Lifecycle

    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
        
        // COMUNICO A MI VISTE CON EL PRESENTER
        presenter?.viewDidLoad()
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeUI.tableView.frame = view.bounds
        homeUI.activityIndicator.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        homeUI.frame = CGRect(x: 0, y: 0, width: view.width , height: view.height)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeUI)
        
        // SPINNER
        homeUI.activityIndicator.center = view.center
        homeUI.activityIndicator.hidesWhenStopped = true
        
        // TABLE VIEW
        view.addSubview(homeUI.tableView)
        homeUI.tableView.delegate = self
        homeUI.tableView.dataSource = self
    }
    
    func configureTableView() {
        homeUI.tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostDescriptionTableViewCell.self, forCellReuseIdentifier: IGFeedPostDescriptionTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostFooterTableViewCell.self, forCellReuseIdentifier: IGFeedPostFooterTableViewCell.identifier)
        homeUI.tableView.separatorStyle = .none
   }
}



// MARK: - TABLEVIEW
extension HomeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSection = presenter?.presenterNumberOfSections() else { return 0 }
        return numberOfSection * 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = indexPath.section
        let boxes = 7
        let position = count % boxes == boxes ? count/boxes : ((count - (count % boxes)) / boxes)
        guard let data = presenter?.cellForRowAt(at: position) else { return UITableViewCell() }
        let model: HomeFeedRenderViewModel = data
        let subSection = count % boxes
        
        switch subSection {
            // HEADER
            case 1:
                switch model.header.renderType {
                    case .header(provider: let userpost):
                        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                        cell.configure(with: userpost)
                        ///cell.delegate = self
                    case .comments, .actions, .primaryContent, .descriptions, .footer : return UITableViewCell()
                }
            
            // POST
            case 2:
                switch model.post.renderType {
                case .primaryContent(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,for: indexPath) as! IGFeedPostTableViewCell
                    cell.configure(with: post)
                    return cell
                case .comments, .actions, .header, .descriptions, .footer : return UITableViewCell()
                }
                
            // ACTION
            case 3:
                switch model.actions.renderType {
                case .actions(_):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                        //cell.delegate = delegateAction
                    return cell
                    case .comments, .header, .primaryContent, .descriptions, .footer : return UITableViewCell()
                }
                
            // DESCRIPTION
            case 4:
                switch model.descriptions.renderType {
                case .descriptions(let post):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
                    cell.setCellWithValuesOf(post)
                    return cell
                case .comments, .header, .primaryContent, .actions, .footer: return UITableViewCell()
                }
                
            // CONTENT
            case 5:
                switch model.comments.renderType {
                case .comments(let comments):
                    let count = comments.count
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                    cell.configure(with: count)
                    return cell
                case .header, .actions, .primaryContent, .descriptions, .footer : return UITableViewCell()
                }
                
            // FOOTER
            case 6:
                switch model.footer.renderType {
                case .footer(let footer):
                    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
                    cell.configure(with: footer)
                    //cell.delegate = delegateFooter
                    ///self.separator(cell: cell)
                    return cell
                case .comments, .header, .primaryContent, .actions, .descriptions: return UITableViewCell()
                }
                
            // DEFAULT
            default: print("Error switch Home")
        }
        return UITableViewCell()
    }
    
    
    // MARK: Heiht TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = 7
            let subSection = indexPath.section % section
            switch subSection {
                case 1:  return  70              // Header
                case 2:  return  tableView.width // Post
                case 3:  return  50              // Actions
                case 4:  return  85              // Description
                case 5:  return  25              // Comment
                case 6:  return  60              // Footer
                default:  return 0
            }
    }
    
    // MARK: Height footer TableView
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = 7
        let subSection = section % section
        return subSection == 6 ? 20 : 0
    }
    
    // MARK: Spacing
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}






// MARK: - A conformance to HomeViewProtocol protocol
extension HomeView: HomeViewProtocol {
    
    func updateUIList() {
        DispatchQueue.main.async {
            self.homeUI.tableView.reloadData()
        }
    }
    
    func startActivity() {
        
        DispatchQueue.main.async {
            print("startActivity")
            self.homeUI.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        
        DispatchQueue.main.async {
            print("stopActivity")
            self.homeUI.activityIndicator.stopAnimating()
            self.homeUI.activityIndicator.hidesWhenStopped = true
        }
    }
}
