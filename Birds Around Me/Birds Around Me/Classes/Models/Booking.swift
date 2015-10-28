//
//  Booking.swift
//  Rental Escapes
//
//  Created by Michael Eilers Smith on 2015-09-06.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Booking:Object {
    dynamic var id = ""
    dynamic var ref = ""
    dynamic var date = ""
    dynamic var adults = ""
    dynamic var children = ""
    dynamic var deposit_amount = ""
    dynamic var deposit_due = ""
    dynamic var deposit_status = ""
    dynamic var balance_amount = ""
    dynamic var balance_due = ""
    dynamic var balance_status = ""
    dynamic var guest_fname = ""
    dynamic var guest_lname = ""
    dynamic var guest_email = ""
    dynamic var guest_tel = ""
    dynamic var contact_button_tel = ""
    dynamic var emergency_tels = ""
    dynamic var manager_name = ""
    dynamic var manager_tel = ""
    dynamic var entrance_instructions = ""
    dynamic var property:Property? = nil
}