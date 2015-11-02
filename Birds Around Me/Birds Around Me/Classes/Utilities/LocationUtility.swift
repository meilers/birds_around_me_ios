//
//  LocationUtility.swift
//  Birds Around Me
//
//  Created by Michael E. Smith on 2015-11-02.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUtility {

    static func calculateDisatnceBetweenTwoLocationsInMeters(source:CLLocation,destination:CLLocation) -> Double {
        
        return source.distanceFromLocation(destination)
    }
}
