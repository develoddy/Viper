
import Foundation
import UIKit

class PasswordView: UIViewController {

    // MARK: Properties
    var presenter: PasswordPresenterProtocol?
    var passwordUI = PasswordUI()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }
    
    private func initMethods() {
        setupView()
        tapContinue()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(passwordUI)
    }
    
    private func loadData() {
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        passwordUI.frame = view.bounds
    }
    
    func tapContinue() {
        let continueButton = passwordUI.continueButton
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
    
    // TAP LOGIN
    @objc private func didTapContinueButton() {
        presenter?.navigatePicView()
    }
}

extension PasswordView: PasswordViewProtocol {
    // TODO: implement view output methods
}
