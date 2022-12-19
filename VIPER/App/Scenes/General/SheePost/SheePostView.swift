
import Foundation
import UIKit

protocol SheePostViewDelegate: AnyObject {
    func formControllerDidFinish(_ controller: SheePostView)
}

class SheePostView: UIViewController {

    // MARK: PROPERTIES
    var presenter: SheePostPresenterProtocol?
    var sheetPostUI = SheePostUI()
    weak var delegate: SheePostViewDelegate?


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
    
    override func didReceiveMemoryWarning() {
        debugPrint("SHEE POST VIEW: LA APLICACION SE ESTA QUEDANDO SIN MEMORIA...")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.sheetHomePostsUI.tableView.frame = CGRect(x: 20, y: 5, width: view.width-40, height: view.height)
        self.sheetPostUI.tableView.frame = view.bounds
        self.sheetPostUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    func initMethods() {
        setupView()
        loadData()
        configureTableView()
        configureDelegates()
        configureHeaderTableView()
    }
    
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        sheetPresentationController.delegate = self
        sheetPresentationController.preferredCornerRadius = 24
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        //sheetPresentationController.largestUndimmedDetentIdentifier = .medium
        //sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController.detents = [
            .medium(),
            //.large(),
        ]
    }
    
    func configureTableView() {
        view.addSubview(sheetPostUI)
        sheetPostUI.tableView.register(SheePostTableViewCell.self, forCellReuseIdentifier: SheePostTableViewCell.identifier)
        sheetPostUI.tableView.separatorStyle = .none
        sheetPostUI.tableView.isScrollEnabled = false
    }
    
    func configureDelegates() {
        sheetPostUI.tableView.delegate = self
        sheetPostUI.tableView.dataSource = self
    }
    
    func configureHeaderTableView() {
        sheetPostUI.tableView.tableHeaderView = createTableHeaderView()
    }
    
    
    // MARK: ACCION DE BOTONES HEADER.
    @objc private func didTapShareButton() {
        print("CLIK SHARED....")
    }
    
    @objc private func didTapLinkButton() {
        print("CLIK LINK....")
    }
    
    @objc private func didTapSaveButton() {
        print("CLIK SAVE....")
    }
    
    @objc private func didTapQrButton() {
        print("CLIK QR....")
    }
    
    @objc private func didDismiss() {
        dismiss(animated: true)
    }
}

extension SheePostView: SheePostViewProtocol {
    func dismiss() {
        self.didDismiss()
    }
}

extension SheePostView: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}


// MARK:  TABLE VIEW
extension SheePostView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.presenterNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SheePostTableViewCell.identifier, for: indexPath) as! SheePostTableViewCell
        let model = self.presenter?.showData(indexPath: indexPath)
        cell.setCellWithValuesOf(with: model)
        // cell.delegate = self
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
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: 120).integral)
        
        let shareButton: UIButton = {
            let button = UIButton()
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
            let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
            button.setImage(image, for: .normal)
            button.backgroundColor = Constants.Color.lightDark
            button.tintColor = .black
            button.layer.cornerRadius = 10
            return button
        }()
        
        let linkButton: UIButton = {
            let button = UIButton()
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
            let image = UIImage(systemName: "link", withConfiguration: config)
            button.setImage(image, for: .normal)
            button.backgroundColor = Constants.Color.lightDark
            button.tintColor = .black
            button.layer.cornerRadius = 10
            return button
        }()
        
        let saveButton: UIButton = {
            let button = UIButton()
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
            let image = UIImage(systemName: "bookmark", withConfiguration: config)
            button.setImage(image, for: .normal)
            button.backgroundColor = Constants.Color.lightDark
            button.tintColor = .black
            button.layer.cornerRadius = 10
            return button
        }()
        
        let qrButton: UIButton = {
            let button = UIButton()
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
            let image = UIImage(systemName: "qrcode.viewfinder", withConfiguration: config)
            button.setImage(image, for: .normal)
            button.backgroundColor = Constants.Color.lightDark
            button.tintColor = .black
            button.layer.cornerRadius = 10
            return button
        }()
        
        header.addSubview(shareButton)
        header.addSubview(linkButton)
        header.addSubview(saveButton)
        header.addSubview(qrButton)
        
        let buttonSize = header.height/1.5
        let buttons = [shareButton, linkButton, saveButton, qrButton ]
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(
                x: (CGFloat(x)*buttonSize)+(22*CGFloat(x+1)),
                //x: (CGFloat(x)*buttonSize)+(3*CGFloat(x+5)),
                y: (header.height-buttonSize)/1.5, //5,
                width: buttonSize,
                height: buttonSize)
        }
        
        // ACCION DE BOTONES EN LA CABECERA.
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        linkButton.addTarget(self, action: #selector(didTapLinkButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        qrButton.addTarget(self, action: #selector(didTapQrButton), for: .touchUpInside)
        
        return header
    }
    
}


extension SheePostView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.choosePostOptions(indexPath: indexPath, in: self)
    }
}
