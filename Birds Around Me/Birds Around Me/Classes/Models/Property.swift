//
//  Property.swift
//  Rental Escapes
//
//  Created by Michael Eilers Smith on 2015-09-06.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Property:Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var location = ""
    dynamic var lat = ""
    dynamic var lng = ""
    dynamic var address = ""
    dynamic var address2 = ""
    dynamic var city = ""
    dynamic var state = ""
    dynamic var zip = ""
    let images = List<Image>()
}