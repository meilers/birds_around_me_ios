//
//  SightingCollectionViewCell.swift
//  Birds Around Me
//
//  Created by Michael E. Smith on 2015-10-30.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

class SightingCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var comNameLabel: UILabel!
    
    @IBOutlet weak var birdImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    func configure(sighting:Sighting, currentLocation:CLLocation?) {
        
        // Bird Name
        let shadow : NSShadow = NSShadow()
//        shadow.shadowOffset = CGSizeMake(-2.0, -2.0)
        shadow.shadowBlurRadius = 10.0
        shadow.shadowColor = UIColor.blackColor()
        
        let attributes = [NSShadowAttributeName : shadow]
        let comNameText = NSAttributedString(string: sighting.comName, attributes: attributes)
        self.comNameLabel.attributedText = comNameText
 
 
        // Image
        var imgurUrl = ""
        
        if let imgurImage = ImagesManager.sharedInstance.imgurImages?[sighting.sciName] {
            imgurUrl = "http://i.imgur.com/\(imgurImage).jpg"
        }
        
//        self.birdImageView.sd_setImageWithURL(NSURL(string:imgurUrl))
        
        
        
        // Date
        let calendar:NSCalendar = NSCalendar.currentCalendar()
        let dayHourMinuteSecond: NSCalendarUnit = NSCalendarUnit(arrayLiteral: .Hour, .Day)
        let components = calendar.components(dayHourMinuteSecond, fromDate: sighting.obsDt, toDate:NSDate(), options: .WrapComponents)
        let nDays = components.day
        let nHours = components.hour
        
        if( nDays > 0 ) {
            if( nDays == 1 ) {
                self.dateLabel.attributedText = NSAttributedString(string: "\(nDays) day ago", attributes: attributes)
            } else {
                self.dateLabel.attributedText = NSAttributedString(string: "\(nDays) days ago", attributes: attributes)
            }
        } else if( nHours > 0 ) {
            if( nHours == 1 ) {
                self.dateLabel.attributedText = NSAttributedString(string: "\(nHours) hour ago", attributes: attributes)
            } else {
                self.dateLabel.attributedText = NSAttributedString(string: "\(nHours) hours ago", attributes: attributes)

            }
        } else {
            self.dateLabel.text = "Just Now"
        }
        
        
        // Distance
        if let currentLocationValue = currentLocation {
            let sightingLocation = CLLocation(latitude: sighting.lat, longitude: sighting.lng)
            let distanceInMeters = LocationUtility.calculateDisatnceBetweenTwoLocationsInMeters(currentLocationValue, destination:sightingLocation)
            
            if( distanceInMeters > 1000 ) {
                self.distanceLabel.attributedText = NSAttributedString(string: "\(String(format: "%.2f",distanceInMeters/1000)) km", attributes: attributes)
            } else {
                self.distanceLabel.attributedText = NSAttributedString(string: "\(distanceInMeters) m", attributes: attributes)
            }
        } else {
            self.distanceLabel.text = ""
        }
    }
    
    
}
