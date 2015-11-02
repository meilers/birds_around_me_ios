//
//  ImageManager.swift
//  Birds Around Me
//
//  Created by Michael J. Eilers Smith on 2015-11-01.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import Foundation

class ImagesManager {
    
    static let sharedInstance = ImagesManager()
    
    var imgurImages:NSDictionary? = nil
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource("imgurImages", ofType: "plist") {
            imgurImages = NSDictionary(contentsOfFile: path)
        }
    }
    
}
