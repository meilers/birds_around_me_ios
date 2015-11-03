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

class SightingsViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    
    @IBOutlet weak var searchView: UIView!
    let searchController = UISearchController(searchResultsController: nil)
    var refreshControl: UIRefreshControl!

    let identifier = "SightingCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!

    // Realm
    let realm = try! Realm()
    let sightings = try! Realm().objects(Sighting).sorted("obsDt", ascending: false)
    var filteredSightings = try! Realm().objects(Sighting).sorted("obsDt", ascending: false)
    
    var notificationToken: NotificationToken?
    
    var locationManager:CLLocationManager! = CLLocationManager()
    var lastCurrentLocation:CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLocationManager()
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
    
    
    func setupUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        setupCollectionView()
    }
    
    func setupNavBar() {
        updateNavBar(title: "Title", subTitle: "SubTitle")
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
        
        // Search
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        
        self.searchView.addSubview(self.searchController.searchBar)
        
        
        // Refresh control
        refreshControl = UIRefreshControl()
        self.collectionView.addSubview(refreshControl)
    }
    
    func updateNavBar(title title:String, subTitle:String) {
        setTitle(title, subtitle: subTitle)
    }
    
    func setTitle(title:String, subtitle:String) {
        //Create a label programmatically and give it its property's
        let titleLabel = UILabel(frame: CGRectMake(0, 0, 0, 0)) //x, y, width, height where y is to offset from the view center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        //Create a label for the Subtitle
        // x, y, width, height where x is set to be half the size of the title (100/4 = 25%) as it starts all the way left.
        let subtitleLabel = UILabel(frame: CGRectMake(0, 22, 0, 0))
        subtitleLabel.backgroundColor = UIColor.clearColor()
        subtitleLabel.textColor = UIColor.lightGrayColor()
        subtitleLabel.font = UIFont.systemFontOfSize(12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        /*Create a view and add titleLabel and subtitleLabel as subviews setting
        * its width to the bigger of both
        * this will crash the program if subtitle is bigger then title
        */
        let titleView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        titleLabel.frame.origin.x = 0
        subtitleLabel.frame.origin.x = 0
        
        
        
        self.navigationItem.titleView = titleView
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
            self.lastCurrentLocation = newLocation
            self.collectionView.reloadData()
            
            SightingsManager.sharedInstance.syncSightingsForLocation(newCoordinate)
            stopLocationManager()
        }
    }
    
    
    // CollectionView - Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.searchController.active) {
            return self.filteredSightings.count
        }
        
        return self.sightings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! SightingCollectionViewCell
        
        let sighting = self.searchController.active ? self.filteredSightings[indexPath.row] : self.sightings[indexPath.row]
        cell.configure(sighting, currentLocation:self.lastCurrentLocation)
        
        return cell
    }
    
    // CollectionView - Delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
    
    // Search - Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let searchText = self.searchController.searchBar.text else { return }

        let searchPredicate = NSPredicate(format: "comName CONTAINS[c] %@", searchText)
        self.filteredSightings = realm.objects(Sighting).filter(searchPredicate)
        self.collectionView.reloadData()
    }
    
    
    // 
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            startLocationManager()
        }
    }
    
    var timer: NSTimer!
    
    func doSomething() {
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
    }
 
    func endOfWork() {
        refreshControl.endRefreshing()
        
        timer.invalidate()
        timer = nil
    }
}

