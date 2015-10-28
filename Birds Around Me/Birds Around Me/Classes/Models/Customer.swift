//
//  Customer.swift
//  Rental Escapes
//
//  Created by Michael Eilers Smith on 2015-09-06.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Customer: Object {
    
    dynamic var id = ""
    dynamic var fname = ""
    dynamic var lname = ""
    dynamic var email = ""
    dynamic var tel = ""
    dynamic var sex = ""
    dynamic var address = ""
    dynamic var address2 = ""
    dynamic var city = ""
    dynamic var state = ""
    dynamic var country = ""
    dynamic var zip = ""
    dynamic var bday = ""
    dynamic var fb_uid = ""
    dynamic var points_balance = ""
    dynamic var reservation_manager:ReservationManager? = nil
    let bookings = List<ProfileBooking>()

    
}