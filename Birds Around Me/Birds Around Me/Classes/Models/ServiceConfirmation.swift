//
//  ServiceConfirmation.swift
//  Rental Escapes
//
//  Created by Michael Eilers Smith on 2015-09-06.
//  Copyright © 2015 Michael Eilers Smith. All rights reserved.
//

import Foundation
import RealmSwift

class ServiceConfirmation:Object {
    dynamic var id = ""
    dynamic var ref = ""
    dynamic var deposit_amount = ""
    dynamic var deposit_due = ""
    dynamic var deposit_pay_to = ""
    dynamic var balance_amount = ""
    dynamic var balance_due = ""
    dynamic var balance_pay_to = ""
    dynamic var notes = ""
    dynamic var cancellation = ""
    dynamic var confirmation = ""
    dynamic var inclusions = ""
    dynamic var instructions = ""
    let custom_fields = List<ServiceConfirmationCustomFields>()
}