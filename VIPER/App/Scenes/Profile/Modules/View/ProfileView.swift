import UIKit

// MARK: VIEW
class ProfileView: UIViewController {

    // MARK:  PROPERTIES
    var presenter: ProfilePresenterProtocol?
    let collectionView = ProfileCollectionsViews.collectionView()
    var profileUI = ProfileUI()
    var token = Token()
    var page: Int! = 0

    // MARK:  LIFECYCLE

    /* TODO: 1. VIEW DID LOAD
     * ES MUY IMPORTANTE QUE SEPAMOS QUE EN ESTE PUNTO SE LLAMA SOLO UNA UNICA VEZ.
     * ESTO ES UN BUEN PUNTO PARA INICIALIZAR TODAS LAS VARIABLES ASOCIADA A LA VISTA
     * O COMENZAR LA CARGA DE DATOS QUE VAMOS A UTILIZAR EN LA VISTA. */
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
        DispatchQueue.main.async {
            self.presenter?.viewDidLoad()
        }
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
    
    /* TODO: INICIALIZAR TODO LOS ELEMENTOS.
     * EN ESTE PUNTO SE INICIALIZA TODO LOS ELEMENTOS. */
    func initMethods() {
        loadData()
        setupView()
        configureActivity()
        configureCollectionView()
        configureCollectionViewHeader()
        configureDelegates()
        configureNavigationItem()
    }
    
    /* TODO: VIPER
     * SE LLAMA AL PRESENTER. */
    func loadData() {
        self.presenter?.viewDidLoad()
    }

    /* TODO: SE CONFIGURA LA VISTA
     * EN ESTE PUNTO SE CONFIGURA LA VISTA. */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = view.bounds
        self.profileUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }

    /* TODO: SETUPVIEW
     * SE AGREGAN LOS COMPONENTES. */
    func setupView() {
        view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .overFullScreen
        view.addSubview(profileUI)
        view.addSubview(collectionView)
    }

    // ACTIVITY
    func configureActivity() {
        profileUI.activityIndicator.center = view.center
        profileUI.activityIndicator.hidesWhenStopped = false
    }

    // COLLECTION
    func configureCollectionView() {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        // collectionView.register(IndicatorCell.self, forCellWithReuseIdentifier: IndicatorCell.identifier)
    }

    // COLLECTION HEADER
    func configureCollectionViewHeader() {
        collectionView.register(StoryFeaturedCollectionTableViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier)

        collectionView.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)

        collectionView.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
    }

    // DELEGATES
    func configureDelegates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

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
    
    
    // NAV ITEMS
    func setupLeftNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("App", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.black
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
    }
    
    func setupRightNavItems() {
        let buttonPlusIcon = UIImage(systemName: "plus")
        let rightBarPlusButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapUploadPost))
        rightBarPlusButton.image = buttonPlusIcon
        rightBarPlusButton.tintColor = .black
        
        let buttonLineIcon = UIImage(systemName: "line.3.horizontal")
        let rightBarLineButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSheeMenu))
        rightBarLineButton.image = buttonLineIcon
        rightBarLineButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [
            rightBarPlusButton,
            rightBarLineButton
        ]
    }
    
    // ACCION BUTTONS
    @objc func didTapSheeMenu() {
        // LLAMAR AL PRESENTER
        // PRESENTAR OTRO MODULO DE SHEE.
        presenter?.gotoSheeMenu()
    }
    
    @objc func didTapUploadPost() {
        presenter?.gotoUploadPost()
    }
}


// MARK: - UIABLEVIEW DATASOURCE
extension ProfileView: UICollectionViewDataSource {
    func numberOfSections( in collectionView: UICollectionView ) -> Int {
        guard let numberOfSections = self.presenter?.presenterNumberOfSections() else { return 0 }
        return numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        if section == 1 { return 0 }
        guard let numberOfRowInsection = self.presenter?.numberOfRowsInsection(section: section) else { return 0 }
        return   numberOfRowInsection
    }

    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath ) -> UICollectionViewCell {
        if indexPath.row != self.presenter?.getPostCount() {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath ) as? PhotoCollectionViewCell else {
                fatalError("PhotoCollectionViewCell cell not exists")
            }
            guard let post = self.presenter?.showPostsData(indexPath: indexPath) else {
                fatalError("error post")
            }
            cell.setCellWithValuesOf(with: post)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.identifier, for: indexPath) as! IndicatorCell
            cell.inidicator.startAnimating()
            if indexPath.row == self.presenter?.getPostCount() {
                cell.inidicator.stopAnimating()
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) - 1, height: 150)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && presenter?.getTotalPages() != self.page {
            guard let isPaginationOn = presenter?.interactor?.remoteDatamanager?.isPaginationOn else { return }
            guard !isPaginationOn else { return }
            self.page += 1
            presenter?.fetchPosts(page: self.page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

// MARK:  UIABLEVIEW DELEGATE
extension ProfileView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // LLAMAR AL PRESENTER.
        self.presenter?.gotoPostScreen(post: self.presenter?.showPostsData(indexPath: indexPath), indexPath: indexPath)
    }
}


// MARK: - UIABLEVIEW FLOW LAYOUT
extension ProfileView: UICollectionViewDelegateFlowLayout {
    // TODO: HEADER & STORY & TABS
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath ) as! ProfileInfoHeaderCollectionReusableView
                let user = self.presenter?.username()
                if user != nil { header.configureProfile(with: user) }
                let tasts = self.presenter?.tasts()
                if tasts != nil { header.setCellWithValuesTastsOf(tasts) }
                header.delegate = self
                return header
            case 1:
                let storyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: StoryFeaturedCollectionTableViewCell.identifier, for: indexPath ) as! StoryFeaturedCollectionTableViewCell
                return storyHeader
            case 2:
                let tabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,for: indexPath) as! ProfileTabsCollectionReusableView
                tabsHeader.delegate = self
                return tabsHeader
            default: break
            }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize(width: collectionView.width, height: collectionView.height / 2.5) }
        if section == 1 { return CGSize(width: collectionView.width, height: 90) }
        return CGSize(width: collectionView.width, height: 50)
    }
}


// MARK: - PROFILE PROTOCOL
extension ProfileView: ProfileViewProtocol {
    func update() {
        self.presenter?.viewDidLoad()
    }
    
    // RELOAD COLLECTION
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // START ACTIVITY
    func startActivity() {
        DispatchQueue.main.async {
            self.profileUI.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.alpha = 0.0
            })
        }
    }

    // STOP ACTIVITY
    func stopActivity() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.profileUI.activityIndicator.stopAnimating()
            self.profileUI.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.alpha = 1.0
            })
        }
    }
}


// MARK: - VANEGAR A OTRO MODULO
extension ProfileView: ProfileInfoHeaderCollectionReusableViewProtocol {
    func didTapPostButton(_header: ProfileInfoHeaderCollectionReusableView) {
        // SCROLL TO THE POSTS.
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
    }
    
    
    // ---------- LLAMAR AL PRESENTER -----------
    // NAVEGAR A OTRO MODULO (LISTPEOPLE)
    // LISTAR A LOS QUE QUE ME SIGUEN.
    func didTapFollowersButton(_header: ProfileInfoHeaderCollectionReusableView) {
        let follower = self.presenter?.showFollowers()
        self.presenter?.gotoListPeopleScreen(following: follower)
    }
    
    // ---------- LLAMAR AL PRESENTER -----------
    // NAVEGAR A OTRO MODULO (LISTPEOPLE)
    // LISTAR A LOS QUE YO SIGO.
    func didTapFollowingButton(_header: ProfileInfoHeaderCollectionReusableView) {
        let following = self.presenter?.showFollowin()
        self.presenter?.gotoListPeopleScreen(following: following)   
    }
    
    // ---------- LLAMAR AL PRESENTER -----------
    // NAVEGAR A OTRO MODULO (EDIT PROFILE)
    // EDITAR NUESTRA INFORMACIÓN DE PERFIL.
    func didTapEditProfileButton( _header: ProfileInfoHeaderCollectionReusableView ) {
        self.presenter?.gotoEitProfileScreen(model: _header.model)
    }
}


// MARK: - ACCIONES DE BOTONES EN EL TAB.
extension ProfileView: ProfileTabsCollectionReusableViewProtocol {
    func didTapGridButtonTab() {
        self.presenter?.viewDidLoad()
    }
    
    func didTapTaggedButtonTab() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
