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

class SightingsManager {
    
    static let sharedInstance = SightingsManager()
    
    func syncSightingsForLocation(location:CLLocationCoordinate2D) {
        
        print("latitude: \(Double(location.latitude))")
        print("longitude: \(Double(location.longitude))")

                
        Alamofire.request(EbirdRouter.DataObsGeoRecent(Double(location.latitude), Double(location.longitude), 50, 5, 500, "en_US", "json"))
            .responseCollection { (response: Response<[Sighting], NSError>) in
                guard response.result.error == nil else { return }
                
                let bites = response.result.value
                
                print(bites)
        }
    }

}
