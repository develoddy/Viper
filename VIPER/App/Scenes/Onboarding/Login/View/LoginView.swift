//
//  LoginView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation
import UIKit

class LoginView: UIViewController {

    // MARK: Properties
    var presenter: LoginPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    func setupView() {
        title = "Login"
        view.backgroundColor = .systemBlue
    }
}

extension LoginView: LoginViewProtocol {
    // TODO: implement view output methods
}
