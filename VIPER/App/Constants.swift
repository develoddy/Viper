//
//  Constants.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 11/11/2020.
//

import  UIKit
struct Constants {
    
    struct LoginData {
        static let username = "eddylujan@gmail.com"
        static let password = "secret"
    }
    
    struct SignUpAlertMessage {
        static let title = "Mensaje"
        static let mensaje = "Se ha detectado que algunos de los campos están vacío. Rellenadlos por favor."
    }
    
    struct BirthdayAlertMessage {
        static let title = "Mensaje"
        static let mensaje = "Se ha detectado que el campo fecha está vacío. Rellenad el campo con tu fecha de nacimiento, por favor."
    }
    
    struct Error {
        static let unauthorized = "Unauthorized"
    }
    
    struct LogInError {
        static let logInInvalidte = "Login Invalido"
        static let title = "Fallo en la verificación"
        static let mensajeError = "El correo electronico o la contraseña son incorrectos."
    }
    
    struct SignUp {
        static let titleAlert = "Sign Up"
        static let subTitleAlert = "User successfully registered"
        static let buttonOkAlert = "User successfully registered"
    }
    
    struct ApiRoutes {
        static let domain   = "http://localhost:3800"
        static let json = "Application/json"
        static let type = "Content-Type"
        static let authorization = "Authorization"
    }
    
    struct headerImage {
        static let forHTTPHeaderFieldContenType = "Content-Type"
        static let valueContentType = "image/jpeg"
        static let forHTTPHeaderFieldUserAgent = "User-agent"
        static let valueUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36"
    }
    
    struct Method {
        static let httpPost = "POST"
        static let httpGet = "GET"
        static let httpPut = "PUT"
        static let httpDelete = "DELETE"
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 9
    }
    
    struct ProfileTabsCollectionReusableViewColor {
        static let padding: CGFloat = 8
    }
    
    struct Color {
        static let blue = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00)
        static let indigo = UIColor(red: 0.40, green: 0.06, blue: 0.95, alpha: 1.00)
        static let purple = UIColor(red: 0.44, green: 0.26, blue: 0.76, alpha: 1.00)
        static let pink = UIColor(red: 0.91, green: 0.24, blue: 0.55, alpha: 1.00)
        static let red = UIColor(red: 0.86, green: 0.21, blue: 0.27, alpha: 1.00)
        static let orange = UIColor(red: 0.99, green: 0.49, blue: 0.08, alpha: 1.00)
        static let yellow = UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        static let green = UIColor(red: 0.16, green: 0.65, blue: 0.27, alpha: 1.00)
        static let teal = UIColor(red: 0.13, green: 0.79, blue: 0.59, alpha: 1.00)
        static let cyan = UIColor(red: 0.32, green: 0.65, blue: 0.98, alpha: 1.00)
        static let white = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        static let gray = UIColor(red: 0.42, green: 0.46, blue: 0.49, alpha: 1.00)
        static let grayDark = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
        static let primary = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00)
        static let secondary = UIColor(red: 0.42, green: 0.46, blue: 0.49, alpha: 1.00)
        static let success = UIColor(red: 0.16, green: 0.65, blue: 0.27, alpha: 1.00)
        static let info = UIColor(red: 0.09, green: 0.64, blue: 0.72, alpha: 1.00)
        static let warning = UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        static let danger = UIColor(red: 0.86, green: 0.21, blue: 0.27, alpha: 1.00)
        static let light = UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
        static let lightDark = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
        static let black = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    }
    
    struct Icon {
        static let photo = "photo"
        static let more = "ellipsis"
        static let filter = "line.horizontal.3.decrease"
    }
    
    struct fontSize {
        static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let semibold = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    struct storyCollections {
        static let createStory = "createStory"
        static let collections = "collections"
    }
    
    struct PostView {
        // CONFiGURACIÓN DE ALERTAS
        static let alertDeleteTitle = "¿Eliminar publicación?"
        static let alertDeleteMessage = "Podrás restaurar esta publicación duante los proximos 30 días desde 'Eliminados recientemente' en 'Tu Actividad' Transcurrido este tiempo, se eliminará definitivamente."
        static let alertDeleteActionTitle = "Eliminar"
        static let alertDeleteActionCancel = "Cancelar"
        
        static let alertUpdateTitle = "Editar contenido de la publicación"
        static let alertUpdateActionSave = "Guardar"
        static let alertUpdateActionCancel = "Cancelar"
    }
    
}
