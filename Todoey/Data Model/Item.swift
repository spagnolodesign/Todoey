//
//  Item.swift
//  Todoey
//
//  Created by Luca Spagnolo on 30/12/2017.
//  Copyright © 2017 Luca Spagnolo. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var text : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory  = LinkingObjects(fromType: Category.self, property: "items")
}
