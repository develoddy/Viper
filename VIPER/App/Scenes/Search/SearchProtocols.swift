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
    func updateUI()
    func startActivity()
    func stopActivity()
}

protocol SearchWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createSearchModule() -> UIViewController
    func gotoSearchResultsUpdating(from view: SearchViewProtocol, resultsComtroller: SearchResultView, filter: String)
    func navigateToPost(from view: SearchViewProtocol, post: Post?)
}

protocol SearchPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireFrame: SearchWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func showUserpostData(indexPath: IndexPath) -> Post
    func searchResultsUpdating(resultsComtroller: SearchResultView, filter: String)
    func gotoPostScreen(post: Post?)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(userpost: [Post])
}

protocol SearchInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    func interactorGetData(token: String)
}

protocol SearchDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData(token: String)
}

protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(userpost: [Post])
}

protocol SearchLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
