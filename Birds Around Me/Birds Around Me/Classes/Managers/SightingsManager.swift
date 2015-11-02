//
//  SightingsManager.swift
//  Birds Around Me
//
//  Created by Michael Eilers Smith on 2015-10-28.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import RealmSwift

class SightingsManager {
    
    static let sharedInstance = SightingsManager()
    
    func syncSightingsForLocation(location:CLLocationCoordinate2D) {
        
                
        Alamofire.request(EbirdRouter.DataObsGeoRecent(37.33233141 /*Double(location.latitude)*/, -122.0312186 /*Double(location.longitude)*/, 50, 5, 500, "en_US", "json"))
            .responseCollection { (response: Response<[Sighting], NSError>) in
                guard response.result.error == nil else { return }
                let result = response.result.value
                
                if let sightings = result {
                    // Query it from any thread
                    dispatch_async(dispatch_queue_create("background", nil)) {
                        let realm = try! Realm()
                        
                        // Delete all objects from the realm
                        do{
                            try realm.write {
                                realm.delete(realm.objects(Sighting))
                                realm.add(sightings)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
        }
    }

}
