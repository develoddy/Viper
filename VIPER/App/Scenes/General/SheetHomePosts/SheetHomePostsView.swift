
import Foundation
import UIKit

class SheetHomePostsView: UIViewController {

    // MARK: PROPERTIES
    var presenter: SheetHomePostsPresenterProtocol?
    var sheetHomePostsUI = SheetHomePostsUI()

    // MARK: LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.sheetHomePostsUI.tableView.frame = CGRect(x: 20, y: 5, width: view.width-40, height: view.height)
        self.sheetHomePostsUI.tableView.frame = view.bounds
        self.sheetHomePostsUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
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
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
    }
    
    func configureTableView() {
        view.addSubview(sheetHomePostsUI)
        sheetHomePostsUI.tableView.register(SheeHomePostsTableViewCell.self, forCellReuseIdentifier: SheeHomePostsTableViewCell.identifier)
        sheetHomePostsUI.tableView.separatorStyle = .none
        sheetHomePostsUI.tableView.isScrollEnabled = false
    }
    
    func configureDelegates() {
        sheetHomePostsUI.tableView.delegate = self
        sheetHomePostsUI.tableView.dataSource = self
    }
    
    func configureHeaderTableView() {
        sheetHomePostsUI.tableView.tableHeaderView = createTableHeaderView()
    }
    
    // MARK: ACCION DE BOTONES HEADER
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
}

extension SheetHomePostsView: SheetHomePostsViewProtocol {
    // TODO: implement view output methods
}


extension SheetHomePostsView: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
}

extension SheetHomePostsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.presenterNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SheeHomePostsTableViewCell.identifier, for: indexPath) as! SheeHomePostsTableViewCell
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

extension SheetHomePostsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // LLAMAR AL PRESENTER.
        print("Clikc.....")
        print(indexPath.item)
        //let post = self.presenter?.getPost()
        //print(post)
        self.presenter?.postSentHome()
        
        
    }
    
}
