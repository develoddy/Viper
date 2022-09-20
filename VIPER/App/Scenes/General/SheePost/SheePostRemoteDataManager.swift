//
//  SheePostRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/9/22.
//  
//

import Foundation

class SheePostRemoteDataManager:SheePostRemoteDataManagerInputProtocol {
    
    
    
    // MARK: PROPERTIES
    var remoteRequestHandler: SheePostRemoteDataManagerOutputProtocol?
    
    
    func formGetData() {
        
        let section01: [SheePostFormModel] = [
            SheePostFormModel(iconImage: "bell.slash",label: "Desactivar notificaciones"),
            SheePostFormModel(iconImage: "pin",label: "Fijar en el perfil"),
            SheePostFormModel(iconImage: "clock",label: "Archivar"),
        ]
        
        let section02: [SheePostFormModel] = [
            SheePostFormModel(iconImage: "pencil",label: "Editar"),
            SheePostFormModel(iconImage: "trash",label: "Eliminar")
        ]
        
        self.remoteRequestHandler?.remoteCallBackData(section01: section01, section02: section02)
    
        
    }
    
    /*
     * BORRAR PUBLICACION.
     */
    func remoteDeletePost(post: Post?, token: String) {
        
        guard let postId = post?.id else {
            return
        }
        
        guard let url = URL( string: Constants.ApiRoutes.domain + "/api/posts/\(postId)" ) else {
            return
        }
        var request = URLRequest( url: url )
        request.httpMethod = Constants.Method.httpDelete
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode( ResMessage.self, from: data )
                    guard let delete = tasks.message else {
                        return
                    }
                    if delete {
                        // LLAMAR AL INTERACTOR
                        self.remoteRequestHandler?.remoteCallBackDeletePost(with: delete)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}
