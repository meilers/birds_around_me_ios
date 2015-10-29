//
//  ViewController.swift
//  Birds Around Me
//
//  Created by Michael J. Eilers Smith on 2015-10-27.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import UIKit
import CoreLocation

class SightingsViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        
        if let newCoordinate = newLocation?.coordinate {
            SightingsManager.sharedInstance.syncSightingsForLocation(newCoordinate)
        }
    }
}

