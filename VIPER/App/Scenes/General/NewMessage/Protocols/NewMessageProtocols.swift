import Foundation
import UIKit

protocol NewMessageViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: NewMessagePresenterProtocol? { get set }
    func updateUI()
}

protocol NewMessageWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createNewMessageModule() -> UIViewController
    func navigateToChat(from view: NewMessageViewProtocol)
}

protocol NewMessagePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: NewMessageViewProtocol? { get set }
    var interactor: NewMessageInteractorInputProtocol? { get set }
    var wireFrame: NewMessageWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInsection(section: Int) -> Int
    func cellForRowAt(at indexPath: IndexPath) -> UserRelationship
    func goToChatScreen()
}

protocol NewMessageInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData( follows: [Follow] )
}

protocol NewMessageInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: NewMessageInteractorOutputProtocol? { get set }
    var localDatamanager: NewMessageLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: NewMessageRemoteDataManagerInputProtocol? { get set }
    func interactorGetFollows(token: String?)
}

protocol NewMessageDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol NewMessageRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: NewMessageRemoteDataManagerOutputProtocol? { get set }
    func remoteGetFollows(token: String?)
}

protocol NewMessageRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackFollows(follows: [Follow])
}

protocol NewMessageLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
