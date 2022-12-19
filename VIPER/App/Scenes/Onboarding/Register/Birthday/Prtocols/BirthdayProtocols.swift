//
//  BirthdayProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 10/10/22.
//  
//

import Foundation
import UIKit

protocol BirthdayViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: BirthdayPresenterProtocol? { get set }
}

protocol BirthdayWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createBirthdayModule() -> UIViewController
    func navigateToPasswordView(from view: BirthdayViewProtocol)
}

protocol BirthdayPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: BirthdayViewProtocol? { get set }
    var interactor: BirthdayInteractorInputProtocol? { get set }
    var wireFrame: BirthdayWireFrameProtocol? { get set }
    func viewDidLoad()
    func navigateToPasswordView()
}

protocol BirthdayInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol BirthdayInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: BirthdayInteractorOutputProtocol? { get set }
    var localDatamanager: BirthdayLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: BirthdayRemoteDataManagerInputProtocol? { get set }
}

protocol BirthdayDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol BirthdayRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: BirthdayRemoteDataManagerOutputProtocol? { get set }
}

protocol BirthdayRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol BirthdayLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
