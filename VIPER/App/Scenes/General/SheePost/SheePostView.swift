
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

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
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
        //delegate?.formControllerDidFinish(self)
    }
}

extension SheePostView: SheePostViewProtocol {
    func dismiss() {
        self.didDismiss()
       
    }
    
    
    /*func alertDelete() {
        
        // SE PRESENTAR UN ALERT PARA BORRAR LA PUBLICACION.
        let alert = UIAlertController(title: "¿Eliminar publicación?",
                                      message: "Podrás restaurar esta publicación duante los proximos 30 días desde 'Eliminados recientemente' en 'Tu Actividad' Transcurrido este tiempo, se eliminará definitivamente.",
                                      preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Eliminar", style: .default) { (action) in
            self.presenter?.deletePost()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }*/
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
