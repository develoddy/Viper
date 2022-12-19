//
//  ListPeopleProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 31/8/22.
//  
//

import Foundation
import UIKit

protocol ListPeopleViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ListPeoplePresenterProtocol? { get set }
    func updateUI()
}

protocol ListPeopleWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createListPeopleModule(following: [Follow], token: LoginToken? ) -> UIViewController
}

protocol ListPeoplePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ListPeopleViewProtocol? { get set }
    var interactor: ListPeopleInteractorInputProtocol? { get set }
    var wireFrame: ListPeopleWireFrameProtocol? { get set }
    func numberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func cellForRowAt(at indexPath: IndexPath) -> UserRelationship
    
    func viewDidLoad()
    var followingReceivedFromProfile: [Follow]  { get set }
    var loginTokenReceivedFromProfile: LoginToken? { get set }
}

protocol ListPeopleInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol ListPeopleInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ListPeopleInteractorOutputProtocol? { get set }
    var localDatamanager: ListPeopleLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ListPeopleRemoteDataManagerInputProtocol? { get set }
}

protocol ListPeopleDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ListPeopleRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ListPeopleRemoteDataManagerOutputProtocol? { get set }
}

protocol ListPeopleRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ListPeopleLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
