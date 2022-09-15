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
        //configureActivity()
        configureTableView()
        configureDelegates()
    }
    
    // VIEWDIDLAYOUTSUBVIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.postUI.tableView.frame = view.bounds
        self.postUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    // SE LLAMA AL PRESENTER
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    func configureActivity() {
        postUI.activityIndicator.center = view.center
        postUI.activityIndicator.hidesWhenStopped = false
    }
    
    // SETUPVIEW
    func setupView() {
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
    func updateUIList() {
        DispatchQueue.main.async {
            self.postUI.tableView.reloadData()
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.postUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.postUI.tableView.alpha = 0.0
            })
        }
    }
    
    func stopActivity() {
        //DispatchQueue.main.asyncAfter(deadline: .now()+4) {
        DispatchQueue.main.async {
            self.postUI.activityIndicator.stopAnimating()
            self.postUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.postUI.tableView.alpha = 1.0
            })
        }
    }
    
    
    // TODO: implement view output methods
    func stateHeart(heart: Heart, post: Post) {
        if heart.id == nil {
            /* --- LLAMAR AL PRESNTER ---
             * LE DECIMOS AL PESENTER QUE QUEREMOS INSERTAR UN LIKE.
             */
            print("PostVIEW - If")
            DispatchQueue.main.async {
                
                self.presenter?.createLike(post: post)
            }
        } else {
            /* --- LLAMAR AL PRESNTER ---
             * LE DECIMOS AL PESENTER QUE QUEREMOS BORRAR UN LIKE.
             */
            print("PostVIEW - ELSE")
            DispatchQueue.main.async {
                self.presenter?.deleteLike(heart: heart)
            }
        }
    }
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
            // ACTIONS.
            case .actions(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                let identity = self.presenter?.getIdentity()
                cell.setCellWithValuesOf(post, identity: identity)
                cell.delegate = self
                return cell
            
            // COMMENTS.
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                let comment = comments[indexPath.row]
                cell.setCellWithValuesOf(with: comment)
                return cell
            
            // CONTENT.
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            
            // HEADER.
            case .header(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: post)
                // cell.delegate = self
                return cell
            
            // DESCRIPTION
            case .descriptions(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath) as! IGFeedPostDescriptionTableViewCell
                cell.setCellWithValuesOf(post)
                //cell.delegate = self
                return cell
            
            /*case .footer(let footer):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath) as! IGFeedPostFooterTableViewCell
                cell.configure(with: footer)
                return cell*/
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
            //case .footer(_)         : return 50 // FOOTER
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK:
extension PostView: IGFeedPostActionsTableViewCellProtocol {
    func didTapLikeButton(_ sender: HeartButton, model: Post) {
        self.presenter?.checkIfLikesExist(post: model)
        let _ = sender.flipLikedState()
    }
    
    func didTapCommentButton(model: Post) {
        self.presenter?.gotoCommentsScreen(post: model)
    }
}
