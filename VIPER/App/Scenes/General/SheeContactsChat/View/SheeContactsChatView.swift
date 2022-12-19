import Foundation
import UIKit

class SheeContactsChatView: UIViewController {

    // MARK: Properties
    var presenter: SheeContactsChatPresenterProtocol?
    var sheeContactsChatUI = SheeContactsChatUI()
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
    
    /* TODO: FRAMES
     * SE CONFIGURA LOS FRAMES DE LA TABLA. */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sheeContactsChatUI.tableView.frame = view.bounds
        self.sheeContactsChatUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    /* TODO: MEMORIA
     * EN ESTE PUNTO SE DETECTA QUE SE ACABA LA MEMORIA DE LA APLICACIÓN. */
    override func didReceiveMemoryWarning() {
        debugPrint("SHEE POST VIEW: LA APLICACION SE ESTA QUEDANDO SIN MEMORIA...")
    }
    
    /* TODO: INICIALIZAR.
     * SE INICIA TODO LOS ELEMENTOS. */
    private func initMethods() {
        setupView()
        loadData()
        configureTableView()
        configureDelegates()
    }
    
    /* TODO: EMPIEZA VIPER.
     + LLAMAR AL PRESENTER.*/
    private func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    /* TODO: CONFIGURACION DE LAS VISTAS.
     * SE CONFIGURA LA VISTA. */
    private func setupView() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(sheeContactsChatUI)
        sheetPresentationController.delegate = self
        sheetPresentationController.preferredCornerRadius = 24
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            //.large(),
        ]
    }
    
    func configureTableView() {
        sheeContactsChatUI.tableView.register(SheeContactsChatTableViewCell.self, forCellReuseIdentifier: SheeContactsChatTableViewCell.identifier)
        // sheeContactsChatUI.tableView.separatorStyle = .none
        sheeContactsChatUI.tableView.isScrollEnabled = false
    }
    
    func configureDelegates() {
        sheeContactsChatUI.tableView.delegate = self
        sheeContactsChatUI.tableView.dataSource = self
        
        searchController.searchResultsUpdater =  self
        //searchController.dimsBackgroundDuringPresentation = false
        //self.navigationItem.searchController = self.searchController
        
        sheeContactsChatUI.tableView.tableHeaderView = searchController.searchBar
    }
    
    @objc private func didDismiss() {
        dismiss(animated: true)
    }
}

// MARK: - SEARCH RESULT
extension SheeContactsChatView: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}


extension SheeContactsChatView: SheeContactsChatViewProtocol {
    
    func updateUI() {
        DispatchQueue.main.async {
            self.sheeContactsChatUI.tableView.reloadData()
        }
    }
    
    func startActivity() {
        //
    }
    
    func stopActivity() {
        //
    }
    
    func dismiss() {
        //self.didDismiss()
        dismiss(animated: true)
    }
}


// MARK: - CONFIGURAR PRESENTACION DE SHEE.
extension SheeContactsChatView: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}

extension SheeContactsChatView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.presenterNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SheeContactsChatTableViewCell.identifier, for: indexPath) as! SheeContactsChatTableViewCell
        let model = self.presenter?.showData(indexPath: indexPath)
        cell.setCellWithValuesOf(with: model)
        return cell
    }
    
    // HEIGHT CELL LIST
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    // HEIGHT HEADER TABLEVIEW
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}

extension SheeContactsChatView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.chooseOptions(indexPath: indexPath, in: self)
    }
}
