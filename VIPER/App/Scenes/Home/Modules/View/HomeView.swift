import Foundation
import UIKit


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
        setupLeftNavItems()
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
