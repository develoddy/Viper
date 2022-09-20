//
//  SheetHomePostsRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/9/22.
//  
//

import Foundation

class SheetHomePostsRemoteDataManager:SheetHomePostsRemoteDataManagerInputProtocol {
    

    var remoteRequestHandler: SheetHomePostsRemoteDataManagerOutputProtocol?
    
    func formGetData() {
        //let sectionnn =  ["trash", "info" , "person.badge.minus"]
    
        // SECTION 2
        let section01_A = SheeHomePostsFormModel(iconImage: "info",label: "Informacion")
        let section01_B = SheeHomePostsFormModel(
            iconImage: "person.badge.minus",
            label: "Dejar de seguir")
        let section01_C = SheeHomePostsFormModel(
            iconImage: "trash",
            label: "Eliminar")
        let section01_D = SheeHomePostsFormModel(
            iconImage: "star",
            label: "Añadir a favoritos")
        let section01_E = SheeHomePostsFormModel(
            iconImage: "clock",
            label: "Pausar a Maria durante 30 días")
        let section01 = Set(arrayLiteral: section01_A, section01_B, section01_C, section01_D, section01_E)
        
        
        // SECTION 2
        let section02_A = SheeHomePostsFormModel(
            iconImage: "folder",
            label: "Documentos")
        let section02_B = SheeHomePostsFormModel(
            iconImage: "graduationcap",
            label: "Graduacion")
        let section02 = Set(arrayLiteral: section02_A, section02_B)
        
        // ------------- ENVIAR DATOS AL INTERACTOR -------------
        // EN ESTE PUNTO SE DEVUELVE LOS DATOS AL INTERACTOR.
        self.remoteRequestHandler?.remoteCallBackData(section01: section01, section02: section02)
    }
}
