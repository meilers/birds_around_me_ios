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

    var locationManager:CLLocationManager! = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationDidBecomeActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationManager()
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopLocationManager()
    }
    
    func applicationDidBecomeActive(notification: NSNotification) {
        startLocationManager()
    }
    
    
    func startLocationManager(){
        locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocationManager() {
        
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        
        if let newCoordinate = newLocation?.coordinate {
            SightingsManager.sharedInstance.syncSightingsForLocation(newCoordinate)
            stopLocationManager()
        }
    }
}

