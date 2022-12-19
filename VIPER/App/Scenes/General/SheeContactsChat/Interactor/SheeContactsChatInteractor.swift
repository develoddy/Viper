import Foundation

class SheeContactsChatInteractor: SheeContactsChatInteractorInputProtocol {
    
    // MARK: PROERTIES
    weak var presenter: SheeContactsChatInteractorOutputProtocol?
    var localDatamanager: SheeContactsChatLocalDataManagerInputProtocol?
    var remoteDatamanager: SheeContactsChatRemoteDataManagerInputProtocol?
    
    
    // MARK: CLOSURES
    var section01 = [SheeContactsChatFormModel]()
    var section02 = [SheeContactsChatFormModel]()
    private var viewModel = [ [ SheeContactsChatFormModel ] ]()
    
    func interactorGetData() {
        remoteDatamanager?.formGetData()
    }
    
    func interactorGetFollows(token: String?) {
        remoteDatamanager?.remoteGetFollows(token: token)
    }
}

extension SheeContactsChatInteractor: SheeContactsChatRemoteDataManagerOutputProtocol {
    // GET DATA FOLLOWS
    func remoteCallBackFollows(section01: [SheeContactsChatFormModel], follows: [Follow]) {
        
        for item in section01 {
            let model = SheeContactsChatFormModel(iconImage: item.iconImage, label: item.label, userId: item.userId)
            self.section01.append(model)
        }
        self.viewModel.append(self.section01)
        
        for item in follows {
            let model = SheeContactsChatFormModel(iconImage: "person.circle.fill", label: item.user?.username ?? "", userId: item.userID ?? 0)
            self.section02.append(model)
        }
        self.viewModel.append(self.section02)
        
        // LLAMAR AL PRESENTER
        self.presenter?.interactorCallBackData(with: self.viewModel)
    }
    
    
    
    func remoteCallBackData(section01: [SheeContactsChatFormModel], section02: [SheeContactsChatFormModel]) {
     
        /*for item in section01 {
            let model = SheeContactsChatFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section01.append(model)
        }
        self.viewModel.append(self.section01)
        
       
        for item in section02 {
            let model = SheeContactsChatFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section02.append(model)
        }
        self.viewModel.append(self.section02)
        
        
        self.presenter?.interactorCallBackData(with: self.viewModel)*/
    }
}
