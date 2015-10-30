//
//  ViewController.swift
//  Birds Around Me
//
//  Created by Michael J. Eilers Smith on 2015-10-27.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import UIKit
import CoreLocation

class SightingsViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var locationManager:CLLocationManager! = CLLocationManager()

    let identifier = "SightingCellIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        initLocationManager()
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
    
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
    
    func initLocationManager() {
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
    
    
    // CollectionView Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        
        if( indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.redColor()
        } else {
            cell.backgroundColor = UIColor.blackColor()

        }
        
        return cell
    }
    
    // Delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
    
    
}

