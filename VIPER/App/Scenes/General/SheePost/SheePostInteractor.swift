//
//  SheePostInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/9/22.
//  
//

import Foundation

class SheePostInteractor: SheePostInteractorInputProtocol {
    
    
    
    // MARK: PROPERTIES
    weak var presenter: SheePostInteractorOutputProtocol?
    var localDatamanager: SheePostLocalDataManagerInputProtocol?
    var remoteDatamanager: SheePostRemoteDataManagerInputProtocol?
    
    // MARK: CLOSURES
    var section01 = [SheePostFormModel]()
    var section02 = [SheePostFormModel]()
    private var viewModel = [ [ SheePostFormModel ] ]()
    
    func interactorGetData() {
        self.remoteDatamanager?.formGetData()
    }
    
    func interactorDeletePost(post: Post?, token: String) {
        self.remoteDatamanager?.remoteDeletePost(post: post, token: token)
    }
}

extension SheePostInteractor: SheePostRemoteDataManagerOutputProtocol {
   
    func remoteCallBackData(section01: [SheePostFormModel], section02: [SheePostFormModel]) {
        // SECTION 01
        for item in section01 {
            let model = SheePostFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section01.append(model)
        }
        self.viewModel.append(self.section01)

        // SECTION 02
        for item in section02 {
            let model = SheePostFormModel(
                iconImage: item.iconImage,
                label: item.label)
            self.section02.append(model)
        }
        self.viewModel.append(self.section02)
        
        // LLAMAR AL PRESENTER.
        self.presenter?.interactorCallBackData(with: self.viewModel)
    }
    
    func remoteCallBackDeletePost(with delete: Bool) {
        // LLAMAR AL PRESENTER
        presenter?.interactorCallBackDeletePost(with: delete)
    }
}
