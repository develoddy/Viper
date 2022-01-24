//
//  SearchProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 24/1/22.
//  
//

import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchPresenterProtocol? { get set }
}

protocol SearchWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSearchModule() -> UIViewController
}

protocol SearchPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireFrame: SearchWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol SearchInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol SearchInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
}

protocol SearchDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
}

protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol SearchLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
