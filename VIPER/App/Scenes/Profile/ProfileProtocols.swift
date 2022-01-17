//
//  ProfileProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    
}

protocol ProfileWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createProfileModule() -> UIViewController
}

protocol ProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol ProfileInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol ProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
}

protocol ProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
}

protocol ProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
