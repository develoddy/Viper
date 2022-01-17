//
//  Closures.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//

import UIKit

class Closures: NSObject {
    typealias userPost              = (_ user: UserPostData)                            -> Void
    typealias message               = (_ message: Operation)                            -> Void
    typealias MensajeError          = (_ mensajeError : String)                         -> Void
    typealias MensajeErrorStatus    = (_ mensajeError : String, _ expiroSesion: Bool)   -> Void
    typealias Login                 = (_ usuario      : ResponseTokenBE)                -> Void
    typealias LogOut                = (_ usuario      : ResponseLogOutBE)               -> Void
}
