

import Foundation

class NewMessagePresenter: NewMessagePresenterProtocol   {
   
    // MARK: Properties
    weak var view: NewMessageViewProtocol?
    var interactor: NewMessageInteractorInputProtocol?
    var wireFrame: NewMessageWireFrameProtocol?
    var token = Token()
    var followingReceivedFromProfile: [Follow] = []
    var viewModelUserRelationship: [ UserRelationship ] = [ ] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    func viewDidLoad() {
        interactor?.interactorGetFollows(token: token.getUserToken().success)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        if self.viewModelUserRelationship.count != 0 {
            return self.viewModelUserRelationship.count
        }
        return 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> UserRelationship {
        return self.viewModelUserRelationship[indexPath.row]
    }
    
    func goToChatScreen() {
        wireFrame?.navigateToChat(from: self.view!)
    }
}

extension NewMessagePresenter: NewMessageInteractorOutputProtocol {
    func interactorCallBackData(follows: [Follow]) {
        for (index, item) in follows.enumerated() {
            self.viewModelUserRelationship.append(
                UserRelationship(
                    username: item.user?.username ?? "",
                    name: item.user?.name ?? "",
                    image: item.user?.profile?.imageHeader ?? "",
                    type: index % 2 == 0 ? .following: .not_following
                )
            )
        }
    }
}
