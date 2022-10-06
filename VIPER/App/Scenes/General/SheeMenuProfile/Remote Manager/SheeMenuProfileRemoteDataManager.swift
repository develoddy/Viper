import Foundation

class SheeMenuProfileRemoteDataManager:SheeMenuProfileRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SheeMenuProfileRemoteDataManagerOutputProtocol?
    
    func formGetData() {
        let section01: [SheeMenuFormModel] = [
            
            SheeMenuFormModel(iconImage: "person.badge.plus",label: "notificaciones"),
            SheeMenuFormModel(iconImage: "bookmark",label: "Guardado"),
            SheeMenuFormModel(iconImage: "star",label: "Favoritos"),
            SheeMenuFormModel(iconImage: "bell",label: "Notificaciones"),
            SheeMenuFormModel(iconImage: "info",label: "Privacidad"),
            SheeMenuFormModel(iconImage: "info",label: "Seguridad"),
            SheeMenuFormModel(iconImage: "info",label: "Cuenta"),
            SheeMenuFormModel(iconImage: "questionmark",label: "Ayuda"),
            SheeMenuFormModel(iconImage: "info",label: "Información"),
        ]
        
        let section02: [SheeMenuFormModel] = [
            SheeMenuFormModel(iconImage: "goforward.plus",label: "Añadir cuenta"),
            SheeMenuFormModel(iconImage: "arrow.left.to.line.compact",label: "Salir")
        ]
        
        self.remoteRequestHandler?.remoteCallBackData(section01: section01, section02: section02)
    }
    
}
