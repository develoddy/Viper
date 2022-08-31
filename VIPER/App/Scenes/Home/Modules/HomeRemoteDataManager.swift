//
//  HomeRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    // MARK:  PROPIERTIES
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    let apiService: APIServiceProtocol
    
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK:  CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK:  FUNCTIONS
    
    // GET DATA
    func remoteGetData(token: String) {
        
        apiService.getUserPost( token: token ) { [ weak self ] ( result ) in
            switch result {
            case .success(let listOf):
                
                // SE OBTIENE LAS PUBLICACIONES
                guard let posts = listOf.resPostImages?.posts else {
                    return
                }
                
                /*
                 * ------------- RECORRER LAS PUBLICACIONES -------------
                 * EN ESTE PUNTO SE RECORRE TODAS LAS PUBLICACIONES Y
                 * GUARDANDO LOS DATOS EN UN MODELO
                 */
                for items in posts {
                    
                    let viewModel = HomeFeedRenderViewModel(
                        header: PostRenderViewModel(
                            renderType: .header( provider: items )
                        ),
                        post: PostRenderViewModel(
                            renderType: .primaryContent( provider: items )
                        ),
                        actions: PostRenderViewModel(
                            renderType: .actions( provider: items )
                        ),
                        descriptions: PostRenderViewModel(
                            renderType: .descriptions( post: items )
                        ),
                        comments: PostRenderViewModel(
                            renderType: .comments( comments: items.comments ?? [] )
                        ),
                        footer: PostRenderViewModel(
                            renderType: .footer( footer: items )
                        )
                    )
                    
                    self?.models.append( viewModel )
                }
                
                guard let models = self?.models else {
                    return
                }
                
                /*
                 * ------------- ENVIAR DATOS AL INTERACTOR -------------
                 * EN ESTE PUNTO DE DEVUELVE LOS DATOS PASANDOLE
                 * AL INTERACTOR.
                 */
                self?.remoteRequestHandler?.remoteCallBackData( with: models )
                
            case .failure(let error):
                print("Error processing  data Home \(error)")
            }
        }
    }
}
