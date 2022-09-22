import UIKit

class PostView: UIViewController {

    // MARK: PROPERTIES
    var presenter: PostPresenterProtocol?
    var postUI = PostUI()
    var shee = SheePostView()
    
    
    // MARK:  LIFECYCLE

    /* TODO: 1. VIEW DID LOAD
     * ES MUY IMPORTANTE QUE SEPAMOS QUE EN ESTE PUNTO SE LLAMA SOLO UNA UNICA VEZ.
     * ESTO ES UN BUEN PUNTO PARA INICIALIZAR TODAS LAS VARIABLES ASOCIADA A LA VISTA
     * O COMENZAR LA CARGA DE DATOS QUE VAMOS A UTILIZAR EN LA VISTA.
     */
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
     * QUE SE EJECUTE JUSTO ANTES DE QUE SE MUESTRE NUESTA VISTA.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    /* TODO: 3. VIEW DID APPEAR
     * YA NOS INDICA QUE LA VISTA SE VA A MOSTRAR EN ESTE PRECISO MOMENTO.
     * EN ESTE PUNTO LA JERARQUIA DE VISTA DE NUESTRO CONTROLADOR YA CONTIENE A TODAS LAS SUB VISTAS.
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    /* TODO: 4. VIEW WILL DISAPPEAR
     * EN ESTE PUNTO TIENE UNA SEMEJANZA DIRECTA CON "VIEW WILL APPEAR".
     * SI "VIEW WILL APPEAR" NOS DECIA QUE ESTABA APUNTO DE APARECER,
     * ENTONCES VIEW WILL DISAPPEAR ESTÁ APUNTO DE DESAPARECER.
     *
     * ESTÁ APUNTO DE DESAPARECER PORQUE VAMOS A NAVEGAR A UN NUEVO CONTROLADOR.
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    /* TODO: 5. VIEW DID DISAPPEAR
     * EN ESTE PUNTO TIENE UNA SEMEJANZA DIRECTA CON "VIEW DID APPEAR".
     * SI "VIEW DID APPEAR" NOS DECIA QUE ESE PRECISO MOMENTO VA A APARECER,
     * ENTONCES VIEW DID DISAPPEAR EN ESTE PRECISO MOMENTO VA A DESAPARACER.
     */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    func initMethods() {
        loadData()
        setupView()
        // configureActivity()
        configureTableView()
        configureDelegates()
        configureNavigationItem()
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
        postUI.tableView.backgroundColor =  .systemBackground
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
    
    private func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(didTapCancel))
        //navigationItem.titleView?.backgroundColor = .red
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // MARK: ACCION BUTTONS NAV.
    @objc func didTapSave() {
        print("Did TAP SAVE....")
        dismiss(animated: true)
        
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
}



extension PostView: PostViewProtocol {
    func deletePost(post: Post?) {
        //self.presenter?.deletePost(post: post)
    }
    
    func dismissModule() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.didTapSave()
        }
    }
    
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
                 cell.delegate = self
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


// MARK: DELEGATES
extension PostView: IGFeedPostActionsTableViewCellProtocol {
    func didTapLikeButton(_ sender: HeartButton, model: Post) {
        self.presenter?.checkIfLikesExist(post: model)
        let _ = sender.flipLikedState()
    }
    
    func didTapCommentButton(model: Post) {
        self.presenter?.gotoCommentsScreen(post: model)
    }
}


// MARK: DELEGATE SHEE POST
extension PostView: IGFeedPostHeaderTableViewCellProtocol {
    func didTapMoreButton(post: Post) {
        //self.presenter.goto
        self.presenter?.gotoSheePostView(post: post)
    }
    
    
}
