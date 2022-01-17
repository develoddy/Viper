//
//  KeyChain.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//


import UIKit

class CDMKeyChain: NSObject {
    
    @discardableResult class func guardarDataEnKeychain(_ data : Data, conCuenta cuenta : String, conServicio servicio : String) -> Bool {
        
        let tienePermiso = self.dispositivoCorrecto()
        
        if tienePermiso == true {
            
            let guardado = self.guardarEnKeychain(data, conCuenta: cuenta, conServicio: servicio)
            return guardado
            
        } /*else {
            
            //exit(-1)
            return false
        }*/
        
        return false
    }
    
    
    //MARK: - Privado
    
    
    private class func dispositivoCorrecto() -> Bool {
        
        //Descomentar para producción, ya que en el simulador tampoco deja ejecutar para evitar injections en el código.
        /*
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") || FileManager.default.fileExists(atPath: "/bin/bash") || FileManager.default.fileExists(atPath: "/usr/sbin/sshd") || FileManager.default.fileExists(atPath: "/etc/apt") {
            
            return false
            
        }else{
            
            let texto = "1234567890"
            
            do{
                try texto.write(toFile: "/private/cache.txt", atomically: true, encoding: String.Encoding.utf8)
                return false
                
            }catch{
                
                if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
                    return false
                }else{
                    return true
                }
            }
        }*/
        
        return true
    }
    
    
    private class func guardarEnKeychain(_ data : Data, conCuenta cuenta : String, conServicio servicio : String) -> Bool {
        
        let keychainData = data as CFData
        
        let query : [String : Any] = [kSecClass as String            : kSecClassGenericPassword as String,
                                      kSecAttrAccount as String      : cuenta,
                                      kSecAttrService as String      : servicio,
                                      kSecValueData as String        : keychainData as Data,
                                      kSecAttrAccessible as String   : kSecAttrAccessibleWhenUnlocked as String]
        
        var keychainError = noErr
        
        keychainError = SecItemAdd(query as CFDictionary, nil)
        
        return keychainError == noErr ? true : false
    }
    
}


