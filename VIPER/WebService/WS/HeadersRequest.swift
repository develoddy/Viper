//
//  HeadersRequests.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/2/22.
//

import Foundation

class HeadersRequest: NSObject {
    
    /* ============================================================================== */
    // MARK: -           CONFIGURATIONS HEADERS.
    /* ============================================================================== */
    class func createHeaderRequest() -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        return diccionarioHeader
    }
    
    class func createHeaderRequestWithCookie(_ aCookie : NSString) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aCookie)", forKey: "Cookie" as NSCopying)
        return diccionarioHeader
    }
    
    class func createHeaderRequestWithToken(_ aToken : String) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aToken)", forKey: "Authorization" as NSCopying)
        return diccionarioHeader
    }
    
}
