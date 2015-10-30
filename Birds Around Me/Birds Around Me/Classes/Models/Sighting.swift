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
    
    convenience required init(comName:String, sciName:String, obsDt:String, howMany:Int?, locID:String?, locationPrivate:Bool?, locName:String?, lat:Double, lng:Double, obsReviewed:Bool?, obsValid:Bool?) {
        self.init()
        self.comName = comName
        self.sciName = sciName
        self.howMany = howMany ?? 1
        self.locID = locID ?? ""
        self.locationPrivate = locationPrivate ?? false
        self.locName = locName ?? ""
        self.lat = lat
        self.lng = lng
        self.obsReviewed = obsReviewed ?? false
        self.obsValid = obsValid ?? false
        
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh-mm"
        self.obsDt = formatter.dateFromString(obsDt) ?? NSDate()
    }
    
    class func decode(json: AnyObject) throws -> Self {
        return try self.init(comName: json => "comName", sciName: json => "sciName", obsDt: json => "obsDt", howMany: try? json => "howMany", locID: try? json => "locID", locationPrivate: try? json => "locationPrivate", locName: try? json => "locName", lat: json => "lat", lng: json => "lng", obsReviewed: json => "obsReviewed", obsValid: json => "obsValid")
    }
    
}