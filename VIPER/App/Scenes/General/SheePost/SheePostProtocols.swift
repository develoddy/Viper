//
//  SheePostProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/9/22.
//  
//

import Foundation
import UIKit

protocol SheePostViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SheePostPresenterProtocol? { get set }
    //func alertDelete()
    func dismiss()
}

protocol SheePostWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSheePostModule(post: Post?) -> UIViewController
    func sendDataPost(from view: SheePostViewProtocol, delete: Bool)
    func navigateToPost(post: Post?, from view: SheePostViewProtocol)
}

protocol SheePostPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SheePostViewProtocol? { get set }
    var interactor: SheePostInteractorInputProtocol? { get set }
    var wireFrame: SheePostWireFrameProtocol? { get set }
    var postReceivedFromPost: Post? { get set }
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showData(indexPath: IndexPath) -> SheePostFormModel?
    func getPost() -> Post?
    func choosePostOptions(indexPath: IndexPath, in viewController: UIViewController)
    func currentTopViewController() -> UIViewController
    func present(in viewController: UIViewController)
}

protocol SheePostInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( with viewModel: [[SheePostFormModel]] )
    func interactorCallBackDeletePost(with delete: Bool)
}

protocol SheePostInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SheePostInteractorOutputProtocol? { get set }
    var localDatamanager: SheePostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SheePostRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
    func interactorDeletePost(post: Post?, token: String)
}

protocol SheePostDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SheePostRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SheePostRemoteDataManagerOutputProtocol? { get set }
    func formGetData()
    func remoteDeletePost(post: Post?, token: String)
}

protocol SheePostRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(section01: [SheePostFormModel], section02: [SheePostFormModel])
    func remoteCallBackDeletePost(with delete: Bool)
}

protocol SheePostLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
