

import Foundation
import UIKit

class ListPeopleView: UIViewController {

    // MARK: PROPERTIES
    var presenter: ListPeoplePresenterProtocol?
    var listPeopleUI = ListPeopleUI()

    // TODO: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMethods()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.listPeopleUI.tableView.frame = view.bounds
        self.listPeopleUI.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    // INIT METHODS
    private func initMethods() {
        self.loadData()
        self.setupView()
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
        view.addSubview(listPeopleUI)
    }
    
    // CONFIGURE TABLEVIEW
    func configureTableView()  {
        listPeopleUI.tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
    }
    
    // DELEGATES
    func configureDelegates() {
        listPeopleUI.tableView.delegate = self
        listPeopleUI.tableView.dataSource = self
    }
}


// MARK: - PROTOCOL
extension ListPeopleView: ListPeopleViewProtocol {
    // TODO: implement view output methods
    func updateUI() {
        DispatchQueue.main.async {
            self.listPeopleUI.tableView.reloadData()
        }
    }
}


// MARK: - UITABLE VIEW DATASOURCE
extension ListPeopleView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRowsInsection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
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
extension ListPeopleView: UITableViewDelegate {
    
}
