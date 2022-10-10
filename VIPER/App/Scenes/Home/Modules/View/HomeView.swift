import Foundation
import UIKit

// MARK: HOMEVIEW
class HomeView: UIViewController {

    // MARK: PROPERTIES
    var presenter: HomePresenterProtocol?
    var homeUI = HomeUI()
    let cellSpacingHeight: CGFloat = 5
    var token = Token()
    var page: Int! = 0
    
    // MARK: LIFECICLY

    // VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
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
    
    func initMethods() {
        loadData()
        setupView()
        configureTableView()
        configureDelegates()
        configureActivity()
        headerTableView()
        configureNavigationItem()
        refresh()
    }
    
    // LLAMAR AL PRESENTER.
    func loadData() {
        presenter?.viewDidLoad()
    }
    
    // SETUP VIEW
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(homeUI)
        homeUI.tableView.allowsSelection = false
        homeUI.tableView.addSubview(homeUI.refreshControl)
    }
    
    // TABLE HEADER
    func headerTableView() {
        homeUI.tableView.tableHeaderView = createTableHeaderView()
    }
    
    // NAV ITEMS
    func configureNavigationItem() {
        confireColorNavigation()
        setupLeftNavItems()
        setupRightNavItems()
    }
    
    func confireColorNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupLeftNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("App", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.black
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
    }
    
    func setupRightNavItems() {
        // Crear
        let buttonPlusIcon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        let rightBarPlusButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSave))
        rightBarPlusButton.image = buttonPlusIcon
        rightBarPlusButton.tintColor = .black
        
        // chat
        let buttonChatIcon = UIImage(systemName: "paperplane.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 19, weight: .semibold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let rightBarChatButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSave))
        rightBarChatButton.image = buttonChatIcon
        rightBarChatButton.tintColor = .black
        
        // bell
        let buttonBellIcon = UIImage(systemName: "bell.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 19, weight: .semibold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let rightBarBellButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSave))
        rightBarBellButton.image = buttonBellIcon
        rightBarBellButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [
            rightBarChatButton,
            rightBarBellButton,
            rightBarPlusButton
        ]
    }
    
    func refresh() {
        homeUI.refreshControl.addTarget(self, action: #selector(updateData(_:) ), for: .valueChanged)
    }
    
    // REFRESCAR LA TABLA
    @objc func updateData(_ refreshControl: UIRefreshControl) {
        if let totalPages = self.presenter?.getTotalPages() {
            if self.page != totalPages {
                if let isPaginationOn = presenter?.interactor?.remoteDatamanager?.isPaginationOn {
                    guard !isPaginationOn else {
                        return
                    }
                    self.page += 1
                    self.homeUI.tableView.tableFooterView = createSpinnerFooter()
                    // LLAMAR AL PRESENTER.
                    presenter?.loadMoreData(page: self.page)
                    if self.page <= totalPages {
                        DispatchQueue.main.async {
                            self.homeUI.tableView.tableFooterView = nil
                        }
                    }
                }
                
            }
        }
        homeUI.refreshControl.endRefreshing()
    }
    
    // ACCION BUTTONS
    @objc func didTapSave() {
        // LLAMAR AL PRESENTER
        // PRESENTAR OTRO MODULO DE SHEE.
        print("rightBarButtonItem Tapped")
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
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
    
    /* EN ESTE PUNTO ESTAMOS A LA ESPERA
     * DE LA COMPROBACION SI EXISTE UN LIKE EN LA DDBB.
     */
    func stateHeart(heart: Heart, post: PostViewData) {
        if heart.id == nil {
            // LLAMAR AL PRESENTER.
            // LE DECIMOS AL PRESENTER QUE QUEREMOS CREAR UN "ME GUSTA".
            DispatchQueue.main.async {
                self.presenter?.createLike(post: post)
            }
        } else {
            // LLAMAR AL PRESENTER.
            // LE DECIMOS AL PRESNETER QUE QUEREMOS BORRAR UN "ME GUSTA".
            DispatchQueue.main.async {
                self.presenter?.deleteLike(heart: heart)
            }
        }
    }
}


// MARK: - ACCION DE BOTONES (LIKE, COMMENT, SHARE)
extension HomeView: IGFeedPostActionsTableViewCellProtocol {
    func didTapLikeButton(_ button: HeartButton, model: PostViewData) {
        // LLAMAR AL PRESENTER.
        // EN ESTE PUNTO QUEREMOS SABER SI "EL ME GUSTA" ESTÁ CREADO O NO.
        self.presenter?.checkIfLikesExist(post: model)
        let _ = button.flipLikedState()
    }
    
    func didTapCommentButton(model: PostViewData) {
        // LLAMAR AL PRESENTER.
        // EN ESTE PUNTO QUEREMOS NAVERGAR A OTRA VISTA PASANDO DATOS DE LA PUBLICACIÓN.
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}

// MARK: - NAVEGAR A OTRO MODULO
extension HomeView: IGFeedPostDescriptionTableViewCellProtocol {
    func didTapComments(model: PostViewData) {
        // LLAMAR AL PRESENTER.
        // EN ESTE PUNTO QUEREMOS NAVEGAR A OTRO MODULO "COMMENTS"
        // PASANDOLE DATOS DE LA PUBLICACIÓN.
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}

// MARK: - NAVEGAR A OTRO MODULO
extension HomeView: IGFeedPostHeaderTableViewCellProtocol {
    func didTapMoreButton(post: PostViewData) {
        
        // LLAMAR AL PRESENTER.
        // EN ESTE PUNTO QUEREMOS NAVEGAR A OTRO MODULO "SHEE HOME POST VIEW"
        // PASANDOLE LOS DATOS DE LA PUBLICACIÑON.
        self.presenter?.gotoSheetHomePostsView(post: post)
    }
}
