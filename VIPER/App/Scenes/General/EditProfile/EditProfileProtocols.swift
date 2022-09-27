//
//  EditProfileProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 30/8/22.
//  
//

import Foundation
import UIKit

protocol EditProfileViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: EditProfilePresenterProtocol? { get set }
}

protocol EditProfileWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createEditProfileModule(model: UserViewData? /*User?*/) -> UIViewController
}

protocol EditProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: EditProfileViewProtocol? { get set }
    var interactor: EditProfileInteractorInputProtocol? { get set }
    var wireFrame: EditProfileWireFrameProtocol? { get set }
    var userReceivedFromProfile: UserViewData? /*User?*/ { get set }
    
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showData(indexPath: IndexPath) -> EditProfileFormModel?
    func showImageProfile() -> String?
}

protocol EditProfileInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( with viewModel: [[EditProfileFormModel]] )
}

protocol EditProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: EditProfileInteractorOutputProtocol? { get set }
    var localDatamanager: EditProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: EditProfileRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
}

protocol EditProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol EditProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: EditProfileRemoteDataManagerOutputProtocol? { get set }
    func localGetData()
}

protocol EditProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData( with section: [ String ] )
}

protocol EditProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
