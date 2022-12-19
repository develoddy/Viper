
import Foundation
import UIKit

class NewMessageView: UIViewController {

    // MARK: Properties
    var presenter: NewMessagePresenterProtocol?
    var newMessageUI = NewMessageUI()

    // MARK: Lifecycle

    /* TODO: 1. VIEW DID LOAD
     * ES MUY IMPORTANTE QUE SEPAMOS QUE EN ESTE PUNTO SE LLAMA SOLO UNA UNICA VEZ.
     * ESTO ES UN BUEN PUNTO PARA INICIALIZAR TODAS LAS VARIABLES ASOCIADA A LA VISTA
     * O COMENZAR LA CARGA DE DATOS QUE VAMOS A UTILIZAR EN LA VISTA. */
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    /* TODO: 2. VIEW WILL APPEAR
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
        self.newMessageUI.tableView.frame = view.bounds
        self.newMessageUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    func initMethods() {
        loadData()
        setupView()
        configureTableView()
        configureTableViewDelegate()
    }
    
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    func setupView() {
        view.backgroundColor = .systemGreen
        view.addSubview(newMessageUI)
    }
    
    func configureTableView() {
        newMessageUI.tableView.register(NewMessageViewCell.self, forCellReuseIdentifier: NewMessageViewCell.identifier)
    }
    
    func configureTableViewDelegate() {
        newMessageUI.tableView.delegate = self
        newMessageUI.tableView.dataSource = self
    }
}

extension NewMessageView: NewMessageViewProtocol {
    func updateUI() {
        DispatchQueue.main.async {
            self.newMessageUI.tableView.reloadData()
        }
    }
    
    // TODO: implement view output methods
}

// MARK: - UITABLE VIEW DATASOURCE
extension NewMessageView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewMessageViewCell.identifier, for: indexPath) as! NewMessageViewCell
        guard let userRelationship = self.presenter?.cellForRowAt(at: indexPath) else {
            return UITableViewCell()
        }
        cell.setCellWithValuesOf(with: userRelationship)
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
extension NewMessageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToChatScreen()
    }
}

