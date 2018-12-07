//
//  ToDoItemManager.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 03/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import Foundation

class ToDoItemManager {
    var todoCount: Int { return todoItems.count }
    var doneChecks: Int { return doneItems.count }
    private var todoItems: [ToDoItem] = [ToDoItem]()
    private var doneItems: [ToDoItem] = [ToDoItem]()
    
    
    func addItem(todoItem: ToDoItem){
        todoItems.append(todoItem)
    }
    func itemAtIndex(index: Int) -> ToDoItem{
        return todoItems[index]
    }
    
    func checkItemAtIndex(index: Int){
        let checkedItem = todoItems.remove(at: index)
        doneItems.append(checkedItem)
    }
    
    func doneItemAtIndex(index: Int) -> ToDoItem{
        return doneItems[index]
    }
    func uncheckItemAtIndex(index: Int) {
        
        let item = doneItems.remove(at: index)
        todoItems.append(item)
    }
}
