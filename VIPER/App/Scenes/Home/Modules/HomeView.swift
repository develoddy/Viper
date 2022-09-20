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
    func stateHeart(heart: Heart, post: Post) {
        if heart.id == nil {
            /* --- LLAMAR AL PRESNTER ---
             * LE DECIMOS AL PESENTER QUE QUEREMOS INSERTAR UN LIKE.
             */
            DispatchQueue.main.async {
                self.presenter?.createLike(post: post)
            }
        } else {
            /* --- LLAMAR AL PRESNTER ---
             * LE DECIMOS AL PESENTER QUE QUEREMOS BORRAR UN LIKE.
             */
            DispatchQueue.main.async {
                self.presenter?.deleteLike(heart: heart)
            }
        }
    }
}


// MARK: ACCION DE BOTONES (LIKE, COMMENT, SHARE)
extension HomeView: IGFeedPostActionsTableViewCellProtocol {
    func didTapLikeButton(_ button: HeartButton, model: Post) {
        /* --- LLAMAR AL PRESNTER ---
         * HACER CONSULTA A LA BASE DE DATOS PARA SABER SI EL LIKE EXISTE O NO.
         */
        self.presenter?.checkIfLikesExist(post: model)
        let _ = button.flipLikedState()
    }
    
    func didTapCommentButton(model: Post) {
        /* --- LLAMAR AL PRESNTER ---
         * SE ENVIA LOS DATOS DEL POSR A LA SIGUIENTE VISTA "COMMENTS".
         */
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}


// MARK: CAMBIAR A LA PANTALLA DE COMENTATIOS
extension HomeView: IGFeedPostDescriptionTableViewCellProtocol {
    func didTapComments(model: Post) {
        self.presenter?.gotoCommentsScreen(userpost: model)
    }
}

extension HomeView: IGFeedPostHeaderTableViewCellProtocol {
    
    func didTapMoreButton(post: Post) {
        // llamar a otro modulo
        self.presenter?.gotoSheetHomePostsView(post: post)
    }
}
