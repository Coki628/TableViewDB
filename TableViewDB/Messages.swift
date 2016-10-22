//
//  Messages.swift
//  TableViewDB
//
//  Created by Coki Kakegawa on 2016/08/26.
//  Copyright © 2016年 CokiLab. All rights reserved.
//

import Foundation
import CoreData

//@objc(Messages)
class Messages: NSManagedObject {
    // Insert code here to add functionality to your managed object subclass
    
    @NSManaged var message: String?
    @NSManaged var time: String?
    @NSManaged var read: NSNumber?
    
}