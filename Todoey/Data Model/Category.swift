//
//  File.swift
//  Todoey
//
//  Created by Luca Spagnolo on 30/12/2017.
//  Copyright © 2017 Luca Spagnolo. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
