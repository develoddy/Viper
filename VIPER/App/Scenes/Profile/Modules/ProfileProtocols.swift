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
    //func displayDataProfile(with viewModel: [Userpost])
    func updateUI()
    func startActivity()
    func stopActivity() 
}

protocol ProfileWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createProfileModule(email: String, name:String, token:String) -> UIViewController
    func gotoPostScreen(from view: ProfileViewProtocol, userpost: Userpost)
}

protocol ProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    var emailReceivedFromHome: String? { get set }
    var nameReceivedFromHome: String? { get set }
    var tokenReceivedFromHome: String? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showProfileData(indexPath: IndexPath) -> Userpost
    func username() -> User?
    func showPost(userpost: Userpost)
    
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with viewModel: [Userpost])
}

protocol ProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(email: String, token: String)
}

protocol ProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData(email: String, token: String)
}

protocol ProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with viewModel: [Userpost])
}

protocol ProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
