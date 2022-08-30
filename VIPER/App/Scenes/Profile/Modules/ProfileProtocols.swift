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
    static func createProfileModule(id: Int, name:String, token:String) -> UIViewController
    func gotoPostScreen(from view: ProfileViewProtocol, post: Post)
}

protocol ProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    var idReceivedFromHome: Int? {get set}
    //var emailReceivedFromHome: String? { get set }
    var nameReceivedFromHome: String? { get set }
    var tokenReceivedFromHome: String? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showPostsData(indexPath: IndexPath) -> Post?
    func username() -> User?
    func tasts() -> ResCounter? 
    func showPost(post: Post)
    
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with viewModel: [User])
    func interactorCallBackTasts(with viewModel: [ResCounter])
    func interactorCallBackPosts(with viewModel: [Post])
}

protocol ProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(id: Int, token: String)
    func interactorGetCounter(id: Int, token: String)
    func interactorGetPosts(id: Int, page: Int, token: String)
}

protocol ProfileDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData(id: Int, token: String)
    func remoteGetCounter(id: Int, token: String)
    func remoteGetPosts(id: Int, page: Int, token: String)
}

protocol ProfileRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with viewModel: [User])
    func remoteCallBackTasts(with viewModel: [ResCounter])
    func remoteCallBackPosts(with viewModel: [Post])
}

protocol ProfileLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
