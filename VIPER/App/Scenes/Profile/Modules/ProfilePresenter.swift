import UIKit

// MARK: PRESENTER
class ProfilePresenter: ProfilePresenterProtocol  {

    // MARK:  PROPERTIES
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    var idReceivedFromHome: Int?
    var nameReceivedFromHome: String?
    var tokenReceivedFromHome: String?
    var token = Token()
    
    // MARK: CLOSURES
    var viewModelPost: [Post] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    var viewModel: [User] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    var viewModelTasts: [ResCounter] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    var viewModelFollows: [Follow] = []
    
    var viewModelFollowers: [Follow] = []
    
    
    // MARK: FUNCTIONS
    
    // LOS DATOS QUE LLEGAN DEL MODULO HOMEVIEW SE LO PASAMOS AL INTERACTOR
    func viewDidLoad() {
        guard let id = idReceivedFromHome, let token = tokenReceivedFromHome else {
            return
        }
        self.interactor?.interactorGetData(id: id, token: token)
        self.interactor?.interactorGetCounter(id: id, token: token)
        self.interactor?.interactorGetPosts(id: id, page: 0, token: token)
        self.interactor?.interactorGetFollowing(page: 0, token: token)
        self.interactor?.interactorGetFollowers(page: 0, token: token)
        
        // self.view?.startActivity()
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return 3
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        if self.viewModelPost.count != 0 {
            return viewModelPost.count
        }
        return 0
    }
    
    // GET DATA
    func showPostsData(indexPath: IndexPath) -> Post? {
        return viewModelPost[indexPath.row]
    }
    
    // GET USER
    func username() -> User? {
        let userpost = self.viewModel.last
        return userpost
    }
    
    // GETS TAST
    func tasts() -> ResCounter? {
        let tasts = self.viewModelTasts.last
        return tasts
    }
    
    // GOTO POST
    func showPost(post: Post) {
        self.wireFrame?.gotoPostScreen(from: view!, post: post)
    }
    
    // SHOW DATA FOLLOWING
    func showFollowin() -> [Follow] {
        return self.viewModelFollows
    }
    
    // SHOW DATA FOLLOWER
    func showFollowers() -> [Follow] {
        return self.viewModelFollowers
    }
    
    // LLAMAR AL WIREFRAME
    func gotoEitProfileScreen(model: User?) {
        self.wireFrame?.navigateToEditProfile(from: view!, model: model )
    }
    
    // LLAMAR AL WIREFRAME
    func gotoListPeopleScreen(following: [Follow]?) {
        guard let following = following else { return }
        self.wireFrame?.gotoListPeopleScreen(following: following, from: view!, token: token.getUserToken())
    }
}


// MARK: - OUTPUT
extension ProfilePresenter: ProfileInteractorOutputProtocol {

    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LOS DATOS DEL PERFIL EN EL MODELO VIEWMODEL.
    func interactorCallBackData(with viewModel: [ User ]) {
        self.viewModel = viewModel
        self.view?.stopActivity()
    }
    
    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LOS CONTADORES EN EL MODELO VIEWMODELTASTS.
    func interactorCallBackTasts(with viewModel: [ ResCounter ] ) {
        self.viewModelTasts = viewModel
        self.view?.stopActivity()
    }
    

    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LAS PUBLICACIONES EN EL MODELO VIEWMODELPOST.
    func interactorCallBackPosts( with viewModel: [ Post ] ) {
        self.viewModelPost = viewModel
        // self.view?.stopActivity()
    }
    

    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LOS FOLLOWING EN EL MODELO VIEWMODELFOLLOWS.
    func interactorCallBackFollowing(with viewModel: [ Follow ]) {
        self.viewModelFollows = viewModel
    }
    
    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDO A LOS FOLLOWER EN EL MODELO VIEWMODELOFOLLOWERS.
    func interactorCallBackFollowers(with viewModel: [ Follow ]) {
        self.viewModelFollowers = viewModel
    }
}
