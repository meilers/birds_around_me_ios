//
//  ImgurRouter.swift
//  Birds Around Me
//
//  Created by Michael J. Eilers Smith on 2015-11-01.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import Foundation
import Alamofire

enum ImgurRouter: URLRequestConvertible {
    static let baseURL = NSURL(string: "http://ebird.org/ws1.1")!
    
    case DataObsGeoRecent(Double,Double,Int,Int,Int,String,String)
    case Bite(Int)
    case BitesTagged(Int)
    
    var URL: NSURL { return EbirdRouter.baseURL.URLByAppendingPathComponent(route.path) }
    
    var route: (path: String, parameters: [String : AnyObject]?) {
        switch self {
            
        case .DataObsGeoRecent (
            let lat,
            let lng,
            let dist,
            let back,
            let maxResults,
            let locale,
            let fmt
            ): return ("/data/obs/geo/recent",
                ["lat": lat, "lng": lng, "dist": dist, "back": back, "maxResults": maxResults, "locale": locale, "fmt": fmt])
            
            
        case .Bite (let biteID): return ("/\(biteID)", nil)
        case .BitesTagged(let tagID): return ("/", ["t": tagID])
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let URLRequest = NSMutableURLRequest(URL: URL)
        
        // set header fields
        URLRequest.setValue("a", forHTTPHeaderField: "Authorization")
        
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: route.parameters ?? [:] ).0
    }
}