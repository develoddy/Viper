//
//  ResponseInJSONWithData.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//

import Foundation

class ResponseInJSONWithData: NSObject {
    
    //MARK: - TRATADO DE RESPUESTA DEL BACKEND.
    class func detResponseInJSONWithData(_ data : Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
        } catch { return nil }
    }
    
    class func getServiceResponse(paraData data           : Data?         ,
                                  conResponse response    : URLResponse?  ,
                                  conError error          : NSError?      )  -> WebResponse {
        var respuesta : Any? = nil
        if error == nil && data != nil {
            respuesta = self.detResponseInJSONWithData(data!)
        }
        
        //        print("======== RESPUES DEL SERVER ========")
        //        print(respuesta ?? "")
        //        print("======== / RESPUES DEL SERVER ========")
        let urlResponse = response as? HTTPURLResponse
        let headerFields : NSDictionary? = urlResponse?.allHeaderFields as NSDictionary?
        let objResponse = WebResponse()
        objResponse.respuestaJSON      = respuesta
        objResponse.statusCode         = urlResponse?.statusCode
        objResponse.respuestaNSData    = data
        objResponse.error              = error
        objResponse.datosCabecera      = headerFields
        objResponse.token              = headerFields?["_token"] as? NSString
        objResponse.cookie             = headerFields?["_token"] as? NSString
        return objResponse
    }
}
