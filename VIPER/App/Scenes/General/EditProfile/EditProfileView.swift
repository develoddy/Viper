

import Foundation
import UIKit

class EditProfileView: UIViewController {

    // MARK: PROPERTIES
    var presenter: EditProfilePresenterProtocol?
    var editProfileUI = EditProfileUI()

    // TODO: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMethods()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.editProfileUI.tableView.frame = view.bounds
        self.editProfileUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    // INIT METHODS
    private func initMethods() {
        self.loadData()
        self.setupView()
        self.configureNavigationItem()
        self.configureTableView()
        self.configureDelegates()
    }
    
    // LLAMAR AL PRESENTER
    func loadData() {
        self.presenter?.viewDidLoad()
    }
    
    // SETUPVIEW
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(editProfileUI)
    }
    
    // CONFIGURE TABLEVIEW
    func configureTableView()  {
        editProfileUI.tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
    }
    
    // DELEGATES
    func configureDelegates() {
        editProfileUI.tableView.delegate = self
        editProfileUI.tableView.dataSource = self
        editProfileUI.tableView.tableHeaderView = createTableHeaderView()
    }
    
    private func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    // ACCION BUTTONS
    @objc func didTapSave() {
        // Save info to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
}



// MARK: - PROTOCOL
extension EditProfileView: EditProfileViewProtocol {
    // TODO: implement view output methods
}


// MARK: - UITABLE VIEW DATASOURCE
extension EditProfileView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.presenterNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        let model = self.presenter?.showData(indexPath: indexPath)
        cell.setCellWithValuesOf(with: model)
        // cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Información privada"
    }
    
    // HEIGHT CELL LIST COMMENTS
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    // HEIGHT HEADER TABLEVIEW
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func headerViewTable() -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
    }
    
    // HEADER TABLEVIEW
    private func createTableHeaderView() -> UIView {
        let header = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height/4).integral)
        
        let size = header.height/1.5
        let profilePhotoButton = UIButton(
            frame: CGRect(
                x: (view.width-size)/2,
                y: (header.height-size)/2,
                width: size,
                height: size) )
        header.addSubview(profilePhotoButton)
        
        let label = UILabel(frame: CGRect(
            x: 10,
            y: profilePhotoButton.bottom+5,
            width: view.width-20,
            height: 20))
        
        label.backgroundColor   = .systemBackground
        label.text              = "Cambiar foto de perfil"
        label.font              = .systemFont(ofSize: 14, weight: .bold)
        label.textColor         = .gray
        label.textAlignment     = .center
        
        header.addSubview(label)
        
        profilePhotoButton.layer.masksToBounds  = true
        profilePhotoButton.layer.cornerRadius   = size/2.0
        profilePhotoButton.tintColor            = .label
        //profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        
        guard let image = self.presenter?.showImageProfile() else {
            return UIView()
        }
        let url = Constants.ApiRoutes.domain + "/api/users/get-image-user/" + image
         
        profilePhotoButton.sd_setBackgroundImage( with: URL(string: url), for: .normal )
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
}

// MARK: - UITABLE VIEW DELEGATE
extension EditProfileView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
