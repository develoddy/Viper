import UIKit

class ApiSession: NSObject {
    static let shared = ApiSession()
    func saveSesion(deUsuario objUsuario : LoginToken)  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do {
            appDelegate.loginSession = objUsuario
            let objUsuario = try JSONEncoder().encode( objUsuario )
            
            CDMKeyChain.guardarDataEnKeychain(
                try NSKeyedArchiver.archivedData(
                    withRootObject: objUsuario,
                    requiringSecureCoding: false),
                conCuenta: "CDMLogin",
                conServicio:"datosUsuario")
        } catch {
            print("Failed to save data... log: OSLog.default, type: .error")
        }
    }
}
