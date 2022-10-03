//
//  ProfileWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/1/22.
//  
//

import Foundation
import UIKit

class ProfileWireFrame: ProfileWireFrameProtocol {
    
    static func createProfileModule(id: Int, name: String, token: String, indexPath: IndexPath) -> UIViewController {

        let profileView = ProfileView()
        let viewController = profileView
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
        let interactor: ProfileInteractorInputProtocol & ProfileRemoteDataManagerOutputProtocol = ProfileInteractor()
        let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()
        let remoteDataManager: ProfileRemoteDataManagerInputProtocol = ProfileRemoteDataManager()
        let wireFrame: ProfileWireFrameProtocol = ProfileWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        
        // DATOS QUE RECIBE DEL MODULO HOMEVIEW
        presenter.idReceivedFromHome = id
        presenter.nameReceivedFromHome = name
        presenter.tokenReceivedFromHome = token
        presenter.indexPathReceivedFromSheePost = indexPath
    
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    

    

    // GOTO NAVIGATION TO POST.
    func gotoPostScreen(from view: ProfileViewProtocol, post: PostViewData? /*Post?*/, indexPath: IndexPath) {
        let newPostView = PostWireFrame.createPostModule(post: post, indexPath: indexPath)
        newPostView.title = post?.user.username
        if let sourceView = view as? UIViewController {
            let navigationController = UINavigationController(rootViewController: newPostView )
            navigationController.modalPresentationStyle = .fullScreen
            sourceView.present( navigationController, animated: true )
        }
    }
    
    // GOTO NAVIGATION TO EDIT PROFILE.
    func navigateToEditProfile(from view: ProfileViewProtocol, model: UserViewData? /*User?*/) {
 
        let newEditProfileView = EditProfileWireFrame.createEditProfileModule(model: model)
        newEditProfileView.title = "Editar Perfil"
        
        if let sourceView = view as? UIViewController {
            let navigationController = UINavigationController( rootViewController: newEditProfileView )
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationItem.largeTitleDisplayMode = .never
            sourceView.present( navigationController, animated: true )
            // sourceView.present( UINavigationController( rootViewController: newEditProfileView ), animated: true )
        }
    }
    
    // GOTO NAVIGATION TO LIST PEOPLE SCREEN.
    func gotoListPeopleScreen(following: [Follow], from view: ProfileViewProtocol, token: LoginToken?) {
        let newListPeople = ListPeopleWireFrame.createListPeopleModule( following: following, token: token )
        newListPeople.title = token?.user?.name
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(newListPeople, animated: true)
        }
    }
}
