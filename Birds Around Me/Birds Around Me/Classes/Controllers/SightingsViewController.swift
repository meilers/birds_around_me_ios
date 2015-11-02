//
//  ViewController.swift
//  Birds Around Me
//
//  Created by Michael J. Eilers Smith on 2015-10-27.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class SightingsViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let identifier = "SightingCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!

    // Realm
    let realm = try! Realm()
    let sightings = try! Realm().objects(Sighting).sorted("obsDt", ascending: false)
    var notificationToken: NotificationToken?
    
    var locationManager:CLLocationManager! = CLLocationManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupLocationManager()
        
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            self.collectionView.reloadData()
        }
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        
        for s in sightings {
            print("name: \(s.comName), obsDt: \(formatter.stringFromDate(s.obsDt))")
        }
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
    
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView.collectionViewLayout = layout
    }
    
    func setupLocationManager() {
        
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationDidBecomeActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }
    
    
    func startLocationManager(){
        
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        
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
        let test = self.sightings.count
        return self.sightings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! SightingCollectionViewCell
        let sighting = self.sightings[indexPath.row]
        
        cell.configure(sighting)
        
        return cell
    }
    
    // Delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2-1, height: collectionView.frame.size.width/2-1)
    }
    
    
}

