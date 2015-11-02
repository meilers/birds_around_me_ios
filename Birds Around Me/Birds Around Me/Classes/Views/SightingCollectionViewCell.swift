//
//  SightingCollectionViewCell.swift
//  Birds Around Me
//
//  Created by Michael E. Smith on 2015-10-30.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import UIKit
import SDWebImage

class SightingCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var comNameLabel: UILabel!
    
    @IBOutlet weak var birdImageView: UIImageView!
    
    func configure(sighting:Sighting) {
        
        // Bird Name
        let shadow : NSShadow = NSShadow()
//        shadow.shadowOffset = CGSizeMake(-2.0, -2.0)
        shadow.shadowBlurRadius = 10.0
        shadow.shadowColor = UIColor.blackColor()
        
        let attributes = [NSShadowAttributeName : shadow]
        let title = NSAttributedString(string: sighting.comName, attributes: attributes)
        self.comNameLabel.attributedText = title
 
 
        // Image
        var imgurUrl = ""
        
        if let imgurImage = ImagesManager.sharedInstance.imgurImages?[sighting.sciName] {
            imgurUrl = "http://i.imgur.com/\(imgurImage).jpg"
        }
        
        self.birdImageView.sd_setImageWithURL(NSURL(string:imgurUrl))
    }
    
    
}
