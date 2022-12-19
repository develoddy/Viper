import Foundation
import UIKit

class EmailView: UIViewController {

    // MARK: Properties
    var presenter: EmailPresenterProtocol?
    var emailUI = EmailUI()
    var searchController = SearchCollectionsViews.searchControllerView()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    /* TODO: 2. VIEW WILL APPERAR
     * QUIERE DECIR QUE NUESTRO CONTROLADOR DE VISTA YA SE HA INSTANCIADO.
     * TAMBIEN QUIERE DECIR QUE LA VISTA SE VA A MOSTRAR PERO AÚN NO LO HA HECHO,
     * ES DECIR QUE TODA LA JERARQUIA DE VISTA ASOCIADO A NUESTRO VIEWCONTROLLER
     * AÚN NO SE HA AÑADIDO HA EL CONTROLADOR PADRE.
     *
     * EN ESTE BLOQUE DE CODIGO PODREMOS AGREGAR CUALQUIER OPERACIÓN QUE QUERRAMOS
     * QUE SE EJECUTE JUSTO ANTES DE QUE SE MUESTRE NUESTA VISTA. */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /* TODO: 3. VIEW DID APPEAR
     * YA NOS INDICA QUE LA VISTA SE VA A MOSTRAR EN ESTE PRECISO MOMENTO.
     * EN ESTE PUNTO LA JERARQUIA DE VISTA DE NUESTRO CONTROLADOR YA CONTIENE A TODAS LAS SUB VISTAS. */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /* TODO: 4. VIEW WILL DISAPPEAR
     * EN ESTE PUNTO TIENE UNA SEMEJANZA DIRECTA CON "VIEW WILL APPEAR".
     * SI "VIEW WILL APPEAR" NOS DECIA QUE ESTABA APUNTO DE APARECER,
     * ENTONCES VIEW WILL DISAPPEAR ESTÁ APUNTO DE DESAPARECER.
     *
     * ESTÁ APUNTO DE DESAPARECER PORQUE VAMOS A NAVEGAR A UN NUEVO CONTROLADOR. */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    /* TODO: 5. VIEW DID DISAPPEAR
     * EN ESTE PUNTO TIENE UNA SEMEJANZA DIRECTA CON "VIEW DID APPEAR".
     * SI "VIEW DID APPEAR" NOS DECIA QUE ESE PRECISO MOMENTO VA A APARECER,
     * ENTONCES VIEW DID DISAPPEAR EN ESTE PRECISO MOMENTO VA A DESAPARACER. */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        debugPrint("POST VIEW: LA APLICACION SE ESTA QUEDANDO SIN MEMORIA...")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.emailUI.tableView.frame = view.bounds
        self.emailUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    func initMethods() {
        loadData()
        setupView()
        delegates()
        configureTableView()
        configureDelegates()
        configureNavigationItem()
    }
    
    func loadData() {
        // LLAMAR AL PRESENTER
        presenter?.viewDidLoad()
    }
    
    func setupView() {
        view.addSubview(emailUI)
        view.backgroundColor = .systemBackground
    }
    
    // DELEGATES
    func delegates() {
        self.searchController.searchResultsUpdater =  self
        self.navigationItem.searchController = self.searchController
    }
    
    // CONFIGURE TABLEVIEW
    func configureTableView()  {
        emailUI.tableView.register(EmailTableViewCell.self, forCellReuseIdentifier: EmailTableViewCell.identifier)
    }
    
    // DELEGATES TABLE
    func configureDelegates() {
        emailUI.tableView.delegate = self
        emailUI.tableView.dataSource = self
    }
    
    func configureNavigationItem() {
        confireColorNavigation()
        setupLeftNavItems()
        setupRightNavItems()
    }
    
    // CONNFIRE NAVIGATION
    func confireColorNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // NAV ITEMS LEFT
    func setupLeftNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("App", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.black
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
    }
    
    // NAV ITEMS RIGHT
    func setupRightNavItems() {
        let buttonCameraIcon = UIImage(systemName: "camera")
        let rightBarCameraButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapUploadPost))
        rightBarCameraButton.image = buttonCameraIcon
        rightBarCameraButton.tintColor = .black
        
        let buttonPencilIcon = UIImage(systemName: "square.and.pencil")
        let rightBarPencilButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSheeContactsChat))
        rightBarPencilButton.image = buttonPencilIcon
        rightBarPencilButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [
            rightBarPencilButton,
            rightBarCameraButton
        ]
    }
    
    // ACCION BUTTONS
    @objc func didTapSheeContactsChat() {
        // LLAMAR AL PRESENTER
        // PRESENTAR OTRO MODULO DE SHEE.
        presenter?.goToSheeContactsChatScreen()
    }
    
    @objc func didTapUploadPost() {
        //presenter?.gotoUploadPost()
    }
}

// MARK: - SEARCH RESULT
extension EmailView: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}
                     



// MARK: - EXTESION
extension EmailView: EmailViewProtocol {
    func setDataFollows(username: String?, userId: Int?) {
        //presenter?.getDaataFollows(username: username, userId: userId)
        print("EmailView: setDataFollows")
        presenter?.goToChatScreen()
        
    }
    
    func updateUIList() {
        //
    }
    
    func startActivity() {
        //
    }
    
    func stopActivity() {
        //
    }
}



// MARK: - UITABLE VIEW DATASOURCE
extension EmailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmailTableViewCell.identifier, for: indexPath) as! EmailTableViewCell
        return cell
    }
    
    // HEIGHT CELL LIST COMMENTS
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    // HEIGHT HEADER TABLEVIEW
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}


// MARK: - UITABLE VIEW DELEGATE
extension EmailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // SE LLAMA AL PRESENTER
        presenter?.goToChatScreen()
        //guard let user = self.presenter?.showProfileData(indexPath: indexPath) else { return }
        //self.presenter?.showPost(user: user)
    }
}
