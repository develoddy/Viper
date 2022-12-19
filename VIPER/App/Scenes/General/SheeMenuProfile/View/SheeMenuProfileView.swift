import Foundation
import UIKit

// MARK: VIEW
class SheeMenuProfileView: UIViewController {

    // MARK: PROPERTIES
    var presenter: SheeMenuProfilePresenterProtocol?
    var sheeMenuProfileUI = SheeMenuProfileUI()

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
    
    /* TODO: MEMORIA
     * EN ESTE PUNTO SE DETECTA QUE SE ACABA LA MEMORIA DE LA APLICACIÓN. */
    override func didReceiveMemoryWarning() {
        debugPrint("SHEE POST VIEW: LA APLICACION SE ESTA QUEDANDO SIN MEMORIA...")
    }
    
    /* TODO: FRAMES
     * SE CONFIGURA LOS FRAMES DE LA TABLA. */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sheeMenuProfileUI.tableView.frame = view.bounds
        self.sheeMenuProfileUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
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
        view.addSubview(sheeMenuProfileUI)
        sheetPresentationController.delegate = self
        sheetPresentationController.preferredCornerRadius = 24
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            //.medium(),
            //.large(),
            .large()
        ]
    }
    
    func configureTableView() {
        sheeMenuProfileUI.tableView.register(SheeMenuTableViewCell.self, forCellReuseIdentifier: SheeMenuTableViewCell.identifier)
        sheeMenuProfileUI.tableView.separatorStyle = .none
        sheeMenuProfileUI.tableView.isScrollEnabled = false
    }
    
    func configureDelegates() {
        sheeMenuProfileUI.tableView.delegate = self
        sheeMenuProfileUI.tableView.dataSource = self
    }
}


// MARK: - CONFIGURAR PRESENTACION DE SHEE.
extension SheeMenuProfileView: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}


// MARK: - OUTPUT
extension SheeMenuProfileView: SheeMenuProfileViewProtocol {
    // TODO: IMPLETEMENT VIEW OUTPUT
}
