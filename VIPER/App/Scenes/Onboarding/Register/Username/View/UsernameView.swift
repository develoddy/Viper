import Foundation
import UIKit

class UsernameView: UIViewController {

    // MARK: Properties
    var presenter: UsernamePresenterProtocol?
    var usernameUI = UsernameUI()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    func initMethods() {
        setupView()
        loadData()
        tapLogIn()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(usernameUI)
    }
    
    override func viewDidLayoutSubviews() {
        usernameUI.frame = view.bounds
    }
    
    private func loadData() {
        presenter?.viewDidLoad()
    }
    
    func tapLogIn() {
        let continueButton = usernameUI.continueButton
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    // TAP LOGIN
    @objc private func didTapContinueButton() {
        presenter?.navigateToBirthdatView()
    }
}

extension UsernameView: UsernameViewProtocol {
    // TODO: implement view output methods
}
