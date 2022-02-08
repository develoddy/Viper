//
//  WSender.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//


import UIKit


class WSenderSimple: NSObject {
    
    // MARK: CONSUMPTION SERVICE SIMPLE

    // POST
    @discardableResult
    class func doPOSTToURL(conURL url: NSString,
                           conPath path: NSString,
                           conParametros parametros: Any?,
                           conCompletion completion: @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = HeadersRequest.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("PostmanRuntime/7.29.0", forHTTPHeaderField: "User-Agent")
        request.addValue("Tue, 08 Feb 2022 09:33:51 GMT", forHTTPHeaderField: "Date")
        request.addValue("no-cache", forHTTPHeaderField: "pragma")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: parametros!,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) {(data, response, error) in
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
    @discardableResult
    class func doGETToURL(conURL url: NSString,
                          conPath path: NSString,
                          conParametros parametros: Any?,
                          conCompletion completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = HeadersRequest.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: parametros!,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) {(data, response, error) in
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
    @discardableResult
    class func doPUTToURL(conURL url: NSString,
                          conPath path: NSString,
                          conParametros parametros: Any?,
                          conCompletion completion: @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = HeadersRequest.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: parametros!,
                    options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) {(data, response, error) in
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
