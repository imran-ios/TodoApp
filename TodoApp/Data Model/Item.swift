//
//  Item.swift
//  TodoApp
//
//  Created by imran on 05/07/20.
//  Copyright © 2020 imran. All rights reserved.
//

import Foundation

class Item:Codable {
    var title : String = ""
    var done :Bool = false
    
    init(title:String) {
        self.title = title
    }
}
