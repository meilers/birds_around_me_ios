//
//  Service.swift
//  Rental Escapes
//
//  Created by Michael Eilers Smith on 2015-09-06.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Service:Object {
    dynamic var id = ""
    dynamic var status = ""
    let confirmation = List<ServiceConfirmation>()
}