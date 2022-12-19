//
//  Token.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//

import UIKit

class Token {
    
    static let shared = Token()
    
    public func getUserToken() -> LoginToken {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.loginSession else {
            return getUserToken()
        }
        return token
    }
}
