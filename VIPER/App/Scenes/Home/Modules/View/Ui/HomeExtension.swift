
import UIKit

// MARK: UITableViewDataSource
extension HomeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSection = presenter?.presenterNumberOfSections() else {
            return 0
        }
        return numberOfSection * 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInsection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = indexPath.section
        let boxes = 6
        let position = count % boxes == boxes ? count / boxes : ((count - (count % boxes)) / boxes)
        guard let data = presenter?.cellForRowAt(at: position) else {
            return UITableViewCell()
        }
        let model: HomeFeedRenderViewModel = data
        let subSection = count % boxes
        switch subSection {
            
            // HEADER
            case 1:
            switch model.header.renderType {
                case .header(provider: let userpost):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath)
                as! IGFeedPostHeaderTableViewCell
                cell.configure(with: userpost)
                cell.delegate = self
                case .comments, .actions, .primaryContent, .descriptions: return UITableViewCell()
            }
            
            // POST
            case 2:
            switch model.post.renderType {
                case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath)
                as! IGFeedPostTableViewCell
                cell.configure(with: post)
                case .comments, .actions, .header, .descriptions: return UITableViewCell()
            }
            
            // ACTION
            case 3:
            switch model.actions.renderType {
                case .actions(let userpost):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath)
                as! IGFeedPostActionsTableViewCell
                let identity = self.presenter?.getIdentity()
                cell.setCellWithValuesOf(userpost, identity: identity)
                cell.delegate = self
                case .comments, .header, .primaryContent, .descriptions: return UITableViewCell()
            }
            
            // DESCRIPTION
            case 4:
            switch model.descriptions.renderType {
                case .descriptions(let post):
                //print("Description: ")
                //print(post.content)
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostDescriptionTableViewCell.identifier, for: indexPath)
                as! IGFeedPostDescriptionTableViewCell
                cell.setCellWithValuesOf(post)
                cell.delegate = self
                case .comments, .header, .primaryContent, .actions: return UITableViewCell()
            }
            
            // COMMENTS
            case 5:
            switch model.comments.renderType {
                case .comments( let comments ):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                let comment = comments[indexPath.row]
                cell.setCellWithValuesOf(with: comment)
                case .header, .actions, .primaryContent, .descriptions: return UITableViewCell()
            }
            
            // FOOTER
            /*case 6:
            switch model.footer.renderType {
                case .footer(let footer):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostFooterTableViewCell.identifier, for: indexPath)
                as! IGFeedPostFooterTableViewCell
                cell.configure(with: footer)
                // cell.delegate = delegateFooter
                case .comments, .header, .primaryContent, .actions, .descriptions: return UITableViewCell()
            }*/
            
            // DEFAULT
            default: print("Error switch Home")
        }
        return UITableViewCell()
    }

    // MARK: Heiht TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = 6
        let subSection = indexPath.section % section
        switch subSection {
            case 1: return 70  // HEADER
            case 2: return tableView.width  // POST
            case 3: return 40  // ACTION
            case 4: return 65  // DESCRIPTION
            case 5: return 30  // COMMENT
            //case 6: return 60  // FOOTER
            default: return 0
        }
    }

    // MARK: Height footer TableView
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = 6
        let subSection = section % section
        return subSection == 5 ? 20 : 0
    }

    // MARK: Spacing
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
}


extension HomeView: UITableViewDelegate {
    
    // FOOTER SPINNER
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    // SCROLL FET MORE DATA
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && self.presenter?.getTotalPages() != self.page {
            guard let isPaginationOn = presenter?.interactor?.remoteDatamanager?.isPaginationOn else { return }
            guard !isPaginationOn else { return }
            self.page += 1
            self.homeUI.tableView.tableFooterView = createSpinnerFooter()
            self.presenter?.loadMoreData(page: self.page)
            
            // CUANDO HA TERMINADO LA EJECUCIÓN DEL SPINNER.
            if self.page < self.presenter?.getTotalPages() ?? 0 {
                DispatchQueue.main.async {
                    self.homeUI.tableView.tableFooterView = nil
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = indexPath.section
        let boxes = 6
        let position = count % boxes == boxes ? count / boxes : ((count - (count % boxes)) / boxes)
        guard let data = presenter?.cellForRowAt(at: position) else { return }
        let model: HomeFeedRenderViewModel = data
        let subSection = count % boxes
        switch subSection {
            case 1:
            switch model.post.renderType {
                case .primaryContent(provider: let userpost):
                guard let id = userpost.user.id,
                      let name = userpost.user.username,
                let token = token.getUserToken().success else { return }
                self.presenter?.gotoProfileScreen(id: id, name: name, token: token)
                default: print("Erro model.post.renderType")
            }
            case 2: break  // Postimage
            case 3: break  // Action
            case 4: break  // Description
            case 5: break  // General
            //case 6: break  // Footer
            default: print("Error switch Home")
        }
    }
}


extension HomeView {
    public func createTableHeaderView() -> UIView {
        let imageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        let writePostButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 10, y: 10, width: 10, height: 0))
            button.setTitle("¡Eddy, dile al mundo lo que piensas!", for: .normal)
            button.contentHorizontalAlignment = .left
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            button.clipsToBounds = true
            button.layer.masksToBounds = true
            return button
        }()
        let uploadImageButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
            button.contentMode = .scaleAspectFit
            button.tintColor = .white
            return button
        }()
        let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 10, width: 40, height: 40)
        imageView.layer.cornerRadius = imageView.height / 2
        let viewWidth = UIScreen.main.bounds.size.width
        let buttonWidth = viewWidth > 500 ? 220.0 : viewWidth / 6
        let labelHeight = headerView.height / 2
        writePostButton.frame = CGRect(
            x: imageView.right + 10, y: 12, width: headerView.width - 8 - imageView.width - buttonWidth,
            height: labelHeight)
        writePostButton.layer.cornerRadius = writePostButton.height / 2
        uploadImageButton.frame = CGRect(
            x: writePostButton.right + 5, y: 12, width: buttonWidth - 10, height: labelHeight)
        //writePostButton.addTarget(self, action: #selector(didTapWritePostButton), for: .touchUpInside)
        headerView.addSubview(separatorView)
        headerView.addSubview(imageView)
        headerView.addSubview(imageView)
        headerView.addSubview(writePostButton)
        headerView.addSubview(uploadImageButton)
        return headerView
    }
}


extension HomeView {
    func configureTableView() {
        homeUI.tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostActionsTableViewCell.self,forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostDescriptionTableViewCell.self,forCellReuseIdentifier: IGFeedPostDescriptionTableViewCell.identifier)
        homeUI.tableView.register(IGFeedPostGeneralTableViewCell.self,forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
//        homeUI.tableView.register(IGFeedPostFooterTableViewCell.self, forCellReuseIdentifier: IGFeedPostFooterTableViewCell.identifier)
        homeUI.tableView.separatorStyle = .none
    }

    func configureDelegates() {
        homeUI.tableView.delegate = self
        homeUI.tableView.dataSource = self
    }

    func configureActivity() {
        homeUI.activityIndicator.center = view.center
        homeUI.activityIndicator.hidesWhenStopped = false
    }
}
