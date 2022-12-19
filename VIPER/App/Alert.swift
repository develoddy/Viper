//
//  Alert.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 3/5/22.
//

import UIKit

class Alert: NSObject {
    typealias acctionSheetCancelar = (()->Void)?
    
    // Alert success
    class func showAlertSuccessWhitTitle(titulo: String,
                                         conMensaje mensaje: String?,
                                         conNombreDeBotonCancelar cancelar: String,
                                         enControlador controller: UIViewController?,
                                         conCompletion completion: (() -> Void)?) {
        
        let alertaController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertController.Style.alert)
        let accionSuccess = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {(action : UIAlertAction) in
            completion?()
        }
        
        alertaController.addAction(accionSuccess)
        if controller == nil {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(alertaController, animated: true, completion: nil)
        } else {
            controller!.present(alertaController, animated: true, completion: nil)
        }
    }
    
    // Alert Error
    class func showAlertErrorWhitTitle(titulo: String,
                                       conMensaje mensaje: String?,
                                       conNombreDeBotonCancelar cancelar : String,
                                       enControlador controller: UIViewController?,
                                       conCompletion completion: (() -> Void)?) {
        
        let alertaController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertController.Style.alert)
        let accionCancelar = UIAlertAction(title: cancelar, style: UIAlertAction.Style.cancel) { (action : UIAlertAction) in
            completion?()
        }
        
        alertaController.addAction(accionCancelar)
        if controller == nil {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(alertaController, animated: true, completion: nil)
        } else {
            controller!.present(alertaController, animated: true, completion: nil)
        }
    }
}
