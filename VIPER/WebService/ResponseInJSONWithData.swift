//import Foundation
//
//class ResponseInJSONWithData: NSObject {
//    
//    // TRATADO DE RESPUESTA DEL BACKEND.
//    // RESPUESTA DE JSON CON DATOS.
//    class func detResponseInJSONWithData(_ data : Data ) -> Any? {
//        do {
//            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
//        } catch { return nil }
//    }
//    
//    // RESPONSE.
//    class func getServiceResponse(paraData data: Data?, conResponse response: URLResponse?, conError error: NSError?) -> WebResponse {
//            var respuesta : Any? = nil
//            if error == nil && data != nil {
//                respuesta = self.detResponseInJSONWithData(data!)
//            }
//            let urlResponse = response as? HTTPURLResponse
//            let headerFields : NSDictionary? = urlResponse?.allHeaderFields as NSDictionary?
//            let objResponse = WebResponse()
//            objResponse.respuestaJSON      = respuesta
//            objResponse.statusCode         = urlResponse?.statusCode
//            objResponse.respuestaNSData    = data
//            objResponse.error              = error
//            objResponse.datosCabecera      = headerFields
//            objResponse.token              = headerFields?["_token"] as? NSString
//            objResponse.cookie             = headerFields?["_token"] as? NSString
//            return objResponse
//    }
//    
//    // RESPONSE API.
//    class func reponseAPI(
//        data: Data?,
//        response: URLResponse?,
//        error: Error?
//    ) {
//        if let error = error {
//            fatalError("Network error: " + error.localizedDescription )
//        }
//        
//        guard let response = response as? HTTPURLResponse else {
//            fatalError("Not a HTTP response")
//        }
//        
//        guard response.statusCode >= 200, response.statusCode < 300 else {
//            fatalError("Invalid HTTP status code: \(response.statusCode)")
//        }
//        
//        guard let _ = data else {
//            print("No data : \(error?.localizedDescription ?? "Unknown error").")
//            return
//        }
//            
//        //print("SUCCESS DATA: \(data)")
//    }
//}
