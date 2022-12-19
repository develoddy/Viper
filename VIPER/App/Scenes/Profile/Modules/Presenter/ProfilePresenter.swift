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
    var postReceivedFromSheetPost: Post?
    var indexPathReceivedFromSheePost: IndexPath?
    var token = Token()
    var isLoadingMore: Bool?
    var page: Int?
    
    // MARK: CLOSURES
    // var viewModelPost: [Post] = [] {
    var postViewData: [PostViewData] = [] {
        didSet {
            self.view?.updateUI()
        }
    }
    
    // var viewModel: [User] = [] {
    var userViewData: [UserViewData] = [] {
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
    
    init() {
        self.isLoadingMore = false
    }
    
    
    // MARK: FUNCTIONS
    
    // LOS DATOS QUE LLEGAN DEL MODULO HOMEVIEW SE LO PASAMOS AL INTERACTOR
    func viewDidLoad() {
        guard let id = idReceivedFromHome, let token = tokenReceivedFromHome else {
            return
        }
        self.interactor?.interactorGetData(id: id, token: token)
        self.interactor?.interactorGetCounter(id: id, token: token)
        self.interactor?.interactorGetFollowing(page: 0, token: token)
        self.interactor?.interactorGetFollowers(page: 0, token: token)
        self.interactor?.interactorGetPosts(id: id, page: 0, token: token, isPagination: false)
        //self.view?.startActivity()
        
    }
    
    func fetchPosts(page: Int) {
        guard let id = token.getUserToken().user?.id, let token = token.getUserToken().success else {
            return
        }
        self.interactor?.interactorGetPosts(id: id, page: page, token: token, isPagination: true)
    }
    
    // GET NUMBER OF SECTION
    func presenterNumberOfSections() -> Int {
        return 3
    }
    
    // GET NUMBER OF ROWS INSECTION
    func numberOfRowsInsection(section: Int) -> Int {
        /*if self.viewModelPost.count != 0 {
            return viewModelPost.count
        }*/
        if self.postViewData.count != 0 {
            return self.postViewData.count
        }
        return 0
    }
    
    func getTotalPages() -> Int {
        return self.page ?? 0
    }
    
    func getPostCount() -> Int {
        return self.postViewData.count //viewModelPost.count
    }
    
    // GET DATA
    func showPostsData(indexPath: IndexPath) -> PostViewData? /*Post?*/ {
        return self.postViewData[indexPath.row]
    }
    
    // GET USER
    func username() -> UserViewData? /*User?*/ {
        //let userpost = self.viewModel.last
        //return userpost
        return self.userViewData.last
    }
    
    // GETS TAST
    func tasts() -> ResCounter? {
        let tasts = self.viewModelTasts.last
        return tasts
    }
    
    // LLAMAR AL WIREFRAME.
    func gotoPostScreen(post: PostViewData? /*Post?*/, indexPath: IndexPath) {
        self.wireFrame?.gotoPostScreen(from: view!, post: post, indexPath: indexPath)
    }
    
    // SHOW DATA FOLLOWING.
    func showFollowin() -> [Follow] {
        return self.viewModelFollows
    }
    
    // SHOW DATA FOLLOWER.
    func showFollowers() -> [Follow] {
        return self.viewModelFollowers
    }
    
    // LLAMAR AL WIREFRAME.
    func gotoEitProfileScreen(model: UserViewData? /*User?*/) {
        self.wireFrame?.navigateToEditProfile(from: view!, model: model )
    }
    
    // LLAMAR AL WIREFRAME.
    func gotoListPeopleScreen(following: [Follow]?) {
        guard let following = following else { return }
        self.wireFrame?.gotoListPeopleScreen(following: following, from: view!, token: token.getUserToken())
    }
    
    // LLAMAR AL WIRERAME.
    func gotoSheeMenu() {
        wireFrame?.presentSheeMenu(from: self.view!)
    }
    
    // LLAMAR AL WIREFRAME.
    func gotoUploadPost() {
        wireFrame?.presentUploadPost(from: self.view!)
    }
}


// MARK: - OUTPUT
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LOS DATOS DEL PERFIL EN EL MODELO VIEWMODEL.
    func interactorCallBackData(with viewModel: [ User ]) {
        let formattedItems = viewModel.map{UserViewData(info: $0)}
        self.userViewData = formattedItems
        //self.view?.stopActivity()
    }
    
    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LOS CONTADORES EN EL MODELO VIEWMODELTASTS.
    func interactorCallBackTasts(with viewModel: [ ResCounter ] ) {
        self.viewModelTasts = viewModel
        //self.view?.stopActivity()
    }
    

    // RECIBE LOS DATOS DE VUELTA DEL INTERACTOR.
    // EN ESTE PUNTO SE GUARDA LAS PUBLICACIONES EN EL MODELO VIEWMODELPOST.
    func interactorCallBackPosts( with viewModel: [ Post ], totalPages: Int ) {
        let formattedItems = viewModel.map{ PostViewData(info: $0)}
        self.postViewData = formattedItems
        self.page = totalPages
    }
    
    func interactorCallBackAppendPosts(with viewModel: [Post]) {
        let formattedItems = viewModel.map{ PostViewData(info: $0)}
        for item in formattedItems {
            self.postViewData.append(item)
        }
        //self.view?.stopActivity()
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
