//
//  WSenderToken.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//

import Foundation

class WSenderToken: NSObject {
    
    // MARK: CONSUMPTION OF SERVICE WITH TOKKEN
    
    // POST
    @discardableResult class func doPOSTTokenToURL(conURL url: NSString,
                                                   conPath path: NSString,
                                                   conParametros parametros: Any?,
                                                   conToken token: String,
                                                   conCompletion completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = HeadersRequest.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = ResponseInJSONWithData.getServiceResponse(
                    paraData: data,
                    conResponse: response,
                    conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    // GET
    @discardableResult class func doGETTokenToURL(conURL url: NSString,
                                                  conPath path: NSString,
                                                  conParametros parametros: Any?,
                                                  conToken token: String,
                                                  conCompletion completion: @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = HeadersRequest.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = ResponseInJSONWithData.getServiceResponse(
                    paraData: data,
                    conResponse: response,
                    conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    // PUT
    @discardableResult class func doPUTTokenToURL(conURL url: NSString,
                                                  conPath path: NSString,
                                                  conParametros parametros: Any?,
                                                  conToken token: String,
                                                  conCompletion completion: @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = HeadersRequest.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = ResponseInJSONWithData.getServiceResponse(
                    paraData: data,
                    conResponse: response,
                    conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
}
