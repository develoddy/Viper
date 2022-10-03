import UIKit

class APIRemote: NSObject {
    
    // MARK: - CONSUMPTION SERVICE SIMPLE
    class func doPOSTToURL(url: String, path: String, params: Any?, completion: @escaping ( _ objRespuesta : WebResponse) -> Void ) -> URLSessionDataTask {
        let urlService = "\(url)/\(path)"
        let url = URL( string: urlService)
        var request = URLRequest(url: url!)
        if params != nil {
            do {
                request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
                request.httpBody = try JSONSerialization.data( withJSONObject: params!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPost
        let task = URLSession.shared.dataTask( with: request ) { data, response, error in
            ApiResponseJSON.apiResponse(data: data, response: response, error: error )
            DispatchQueue.main.async( execute: {
                let objRespuesta = ApiResponseJSON.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        task.resume()
        return task
    }
    
    
    // MARK: - CONSUMPTION OF SERVICE WITH TOKKEN
    // POST
    class func doPOSTTokenToURL(url: String, path: String, params: Any?, token: String, completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        
        let configurationSession = URLSessionConfiguration.default
        configurationSession.httpAdditionalHeaders = HeadersRequest.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configurationSession)
        
        let urlService = "\(url)/\(path)"
        let url = URL( string: urlService)
        var request = URLRequest(url: url!)
        
        if params != nil {
            do {
                request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
                request.httpBody = try JSONSerialization.data( withJSONObject: params!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPost
        let task = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async( execute: {
                let objRespuesta = ApiResponseJSON.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        task.resume()
        return task
    }
    
    // GET
    class func doGETTokenToURL(url: String, path: String, params: Any?, token: String, completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        let configurationSession = URLSessionConfiguration.default
        configurationSession.httpAdditionalHeaders = HeadersRequest.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configurationSession)
        
        let urlService = "\(url)/\(path)"
        let url = URL( string: urlService)
        var request = URLRequest(url: url!)
        
        if params != nil {
            do {
                request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
                request.httpBody = try JSONSerialization.data( withJSONObject: params!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpGet
        let task = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async( execute: {
                let objRespuesta = ApiResponseJSON.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        task.resume()
        return task
    }
    
    // DELETE
    class func doDELETETokenToURL(url: String, path: String, params: Any?, token: String, completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        let configurationSession = URLSessionConfiguration.default
        configurationSession.httpAdditionalHeaders = HeadersRequest.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configurationSession)
        
        let urlService = "\(url)/\(path)"
        let url = URL( string: urlService)
        var request = URLRequest(url: url!)
        
        if params != nil {
            do {
                request.setValue(Constants.ApiRoutes.json, forHTTPHeaderField: Constants.ApiRoutes.type)
                request.httpBody = try JSONSerialization.data( withJSONObject: params!, options: JSONSerialization.WritingOptions.prettyPrinted)
                
            } catch {}
        }
        request.httpMethod = Constants.Method.httpDelete
        let task = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async( execute: {
                let objRespuesta = ApiResponseJSON.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        task.resume()
        return task
    }
    
}
