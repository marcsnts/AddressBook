//
//  CoreDataHelper.swift
//  AddressBook
//
//  Created by Marc Santos on 2017-01-23.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
