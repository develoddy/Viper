//
//  Constants.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 11/11/2020.
//

import  UIKit
struct Constants {
    
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
        static let titleAlertVerificationFailed = "Verification Failed"
        static let mensajeError = "The email or password you entered is incorrect."
    }
    
    struct SignUp {
        static let titleAlert = "Sign Up"
        static let subTitleAlert = "User successfully registered"
        static let buttonOkAlert = "User successfully registered"
    }
    
    struct ApiRoutes {
        //static let domain = "http://127.0.0.1:8000"
        //static let domain = "https://develoddy.com"
        //static let domain = "https://develoddy.com/laravelfront"
        //static let domain   = "http://127.0.0.1:3800"
        static let domain   = "http://localhost:3800"
        
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
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 9
    }
    
    struct ProfileTabsCollectionReusableViewColor {
        static let padding: CGFloat = 8
    }
    
    struct Color {
        static let appBlue = UIColor(red: 0.00, green: 0.78, blue: 1.00, alpha: 1.00)
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
}
