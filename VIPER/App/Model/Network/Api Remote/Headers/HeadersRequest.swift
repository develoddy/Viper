import Foundation

class HeadersRequest: NSObject {
    
    // MARK: CONFIGURATIONS HEADERS

    class func createHeaderRequest() -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject(Constants.ApiRoutes.json, forKey: Constants.ApiRoutes.type as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: Constants.ApiRoutes.type as NSCopying)
        diccionarioHeader.setObject(Constants.ApiRoutes.json, forKey: "Accept" as NSCopying)
        return diccionarioHeader
    }
    
    class func createHeaderRequestWithCookie(_ aCookie : NSString) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: Constants.ApiRoutes.type as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aCookie)", forKey: "Cookie" as NSCopying)
        return diccionarioHeader
    }
    
    class func createHeaderRequestWithToken(_ aToken : String) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject(Constants.ApiRoutes.json, forKey: Constants.ApiRoutes.type as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: Constants.ApiRoutes.type as NSCopying)
        diccionarioHeader.setObject(Constants.ApiRoutes.json, forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aToken)", forKey: Constants.ApiRoutes.authorization as NSCopying)
        return diccionarioHeader
    }
}
