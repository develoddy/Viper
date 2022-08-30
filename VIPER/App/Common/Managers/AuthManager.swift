//
//  AuthManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 5/2/22.
//

import Foundation

final class AuthManager {
    static let share = AuthManager()
    
    
    //MARK: Login
    public func login(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        //if let email = email {
            /*let objUser = UserBE()
            objUser.email = email
            objUser.password = password*/
            
            ///Call to API
            BCApiRest.login( email:email, password:password ) { (objUsuario) in
                completion(true)
            } conCompletionIncorrecto: { (mensajeError) in
                completion(false)
            }
        //}
    }
    
    
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool? {
        return false
    }
    
    public func refreshAccessToken() {
        
    }
    
    
    private func cacheToken() {
        
    }
}
