//
//  SightingCollectionViewCell.swift
//  Birds Around Me
//
//  Created by Michael E. Smith on 2015-10-30.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import UIKit

class SightingCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var comNameLabel: UILabel!
    
    func configure(sighting:Sighting) {
        
        self.comNameLabel.text = sighting.comName
    }
    
    
}
