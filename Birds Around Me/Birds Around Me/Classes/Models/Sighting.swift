//
//  Observation.swift
//  Birds Around Me
//
//  Created by Michael E. Smith on 2015-10-28.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import Foundation
import RealmSwift
import Decodable

class Sighting:Object, Decodable {
    
    enum EncryptionError: ErrorType {
        case Empty
        case Short
    }
    
    dynamic var comName = ""
    dynamic var sciName = ""
    dynamic var obsDt = NSDate()
    dynamic var howMany = 0
    dynamic var locID = ""
    dynamic var locationPrivate = false
    dynamic var locName = ""
    dynamic var lat = 0.0
    dynamic var lng = 0.0
    dynamic var obsReviewed = false
    dynamic var obsValid = false
    
    required init(comName:String, sciName:String, obsDt:String, howMany:Int?, locID:String?, locationPrivate:Bool?, locName:String?, lat:Double, lng:Double, obsReviewed:Bool?, obsValid:Bool?) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    class func decode(json: AnyObject) throws -> Self {
        return try self.init(comName: json => "comName", sciName: json => "sciName", obsDt: json => "obsDt", howMany: try? json => "howMany", locID: try? json => "locID", locationPrivate: try? json => "locationPrivate", locName: try? json => "locName", lat: json => "lat", lng: json => "lng", obsReviewed: json => "obsReviewed", obsValid: json => "obsValid")
    }
    
//    public class func decode(json: AnyObject) throws -> Self {
//        let string = try String.decode(json)
//        
//        guard let date = ISO8601DateFormatter.dateFromString(string) else {
//            throw NSDateDecodingError.InvalidStringFormat
//        }
//        
//        return self.init(timeIntervalSince1970: date.timeIntervalSince1970)
//    }
    
}