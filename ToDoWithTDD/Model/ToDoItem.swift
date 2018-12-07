//
//  ToDoItem.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 03/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        if lhs.location?.name != rhs.location?.name{
            return false
        }
        if lhs.title != rhs.title{
            return false
        }
        return true
    }
    
    let title: String
    let itemDescription: String?
    let timeStamp: Double?
    let location: Location?
    
    init(title: String,
         itemDescription: String? = nil,
         timeStamp: Double? = nil,
         location: Location? = nil){
        self.title = title
        self.itemDescription = itemDescription
        self.timeStamp = timeStamp
        self.location = location
    }
}
