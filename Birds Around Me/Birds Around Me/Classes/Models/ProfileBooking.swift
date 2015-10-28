//
//  Booking.swift
//  Rental Escapes
//
//  Created by Michael Eilers Smith on 2015-09-06.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileBooking: Object {
    dynamic var id = ""
    dynamic var status = ""
    dynamic var checkin = ""
    dynamic var checkout = ""
    dynamic var property_url = ""
    dynamic var property_pic = ""
    dynamic var location = ""
    dynamic var survey_link = ""
}