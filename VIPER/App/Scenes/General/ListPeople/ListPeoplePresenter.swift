import Foundation

class ListPeoplePresenter: ListPeoplePresenterProtocol  {

    // MARK: PROPERTIES
    weak var view: ListPeopleViewProtocol?
    var interactor: ListPeopleInteractorInputProtocol?
    var wireFrame: ListPeopleWireFrameProtocol?
    var loginTokenReceivedFromProfile: LoginToken?
    var followingReceivedFromProfile: [Follow] = []
    var viewModelUserRelationship: [ UserRelationship ] = [ ] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    // TODO: IMPLEMENT PRESENTER METHODOS
    func viewDidLoad() {
        for ( index, item ) in self.followingReceivedFromProfile.enumerated() {
            self.viewModelUserRelationship.append(UserRelationship(
                username: item.user?.username ?? "", // username ?? "",
                name: item.user?.name ?? "",
                image: item.user?.profile?.imageHeader ?? "",
                type: index % 2 == 0 ? .following: .not_following ) )
        }
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
}


// MARK: - OUT PUT
extension ListPeoplePresenter: ListPeopleInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
