//
//  ListPeopleView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 31/8/22.
//  
//

import Foundation
import UIKit

class ListPeopleView: UIViewController {

    // MARK: Properties
    var presenter: ListPeoplePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListPeopleView: ListPeopleViewProtocol {
    // TODO: implement view output methods
}
