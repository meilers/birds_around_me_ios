//
//  ConstraintUtility.swift
//  Rental Escapes
//
//  Created by Michael E. Smith on 2015-10-13.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import UIKit

class ConstraintUtility {
    
    class func changeMultiplier(constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
        item: constraint.firstItem,
        attribute: constraint.firstAttribute,
        relatedBy: constraint.relation,
        toItem: constraint.secondItem,
        attribute: constraint.secondAttribute,
        multiplier: multiplier,
        constant: constraint.constant)
        
        NSLayoutConstraint.deactivateConstraints([constraint])
        NSLayoutConstraint.activateConstraints([newConstraint])
        
        return newConstraint
    }
}