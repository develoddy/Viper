//
//  HomeRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    // MARK: - PROPIERTIES
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    // We defined the FakeAPIServiceProtocol in the APIService.swift file.
    let apiService: APIServiceProtocol
    
    // The collection that will contain our fetched data
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK: - FUNCTIONS
    
    // GET DATA
    func remoteGetData(token: String) {
        apiService.getUserPost( token: token ) { [ weak self ] ( result ) in
            switch result {
            case .success(let listOf):
                guard let userposts = listOf.userpost else { return }
                for items in userposts {
                    guard let comments = items.comments else { return }
                    let viewModel = HomeFeedRenderViewModel(
                        header      : PostRenderViewModel(renderType: .header(provider: items)),
                        post        : PostRenderViewModel(renderType: .primaryContent(provider: items)),
                        actions     : PostRenderViewModel(renderType: .actions(provider: items)),
                        descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
                        comments    : PostRenderViewModel(renderType: .comments(comments: comments)),
                        footer      : PostRenderViewModel(renderType: .footer(footer: items)))
                    self?.models.append( viewModel )
                }
                
                // TODO: ENVIAR DE VUELTA LOS DATOS AL INTERACTOR
                self?.remoteRequestHandler?.remoteCallBackData(with: self?.models ?? [])
                
            case .failure(let error):
                print("Error processing  data Home \(error)")
            }
        }
    }
}
