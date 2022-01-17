//
//  ProfileProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation
import UIKit

protocol ProfileViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: ProfilePresenterProtocol? { get set }
}

protocol ProfileWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createProfileModule() -> UIViewController
}

protocol ProfilePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol ProfileInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol ProfileInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
}

protocol ProfileDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
}

protocol ProfileRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ProfileLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
