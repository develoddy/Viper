//
//  SheetHomePostsProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/9/22.
//  
//

import Foundation
import UIKit

protocol SheetHomePostsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SheetHomePostsPresenterProtocol? { get set }
}

protocol SheetHomePostsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSheetHomePostsModule(post: PostViewData?) -> UIViewController
}

protocol SheetHomePostsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SheetHomePostsViewProtocol? { get set }
    var interactor: SheetHomePostsInteractorInputProtocol? { get set }
    var wireFrame: SheetHomePostsWireFrameProtocol? { get set }
    var postReceivedFromHome: PostViewData? { get set }
    
    func viewDidLoad()
    func presenterNumberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showData(indexPath: IndexPath) -> SheeHomePostsFormModel?
    func getPost() -> PostViewData?
    func postSentHome()
}

protocol SheetHomePostsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( with viewModel: [[SheeHomePostsFormModel]] )
}

protocol SheetHomePostsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SheetHomePostsInteractorOutputProtocol? { get set }
    var localDatamanager: SheetHomePostsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SheetHomePostsRemoteDataManagerInputProtocol? { get set }
    func interactorGetData()
}

protocol SheetHomePostsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SheetHomePostsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SheetHomePostsRemoteDataManagerOutputProtocol? { get set }
    func formGetData()
}

protocol SheetHomePostsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(section01: Set<SheeHomePostsFormModel>, section02: Set<SheeHomePostsFormModel>)
}

protocol SheetHomePostsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
