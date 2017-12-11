//
//  Account.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 12/9/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit
import CoreData

class Account: NSManagedObject {

    func printName() {
        print(accountName!)
    }
}
