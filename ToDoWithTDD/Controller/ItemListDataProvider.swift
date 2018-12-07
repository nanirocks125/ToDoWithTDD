//
//  ItemListDataProvider.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var itemManager: ToDoItemManager?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        
        let numberOfRows: Int
        
        switch itemSection {
        case .ToDo:
            numberOfRows = itemManager.todoCount
        case .Done:
            numberOfRows = itemManager.doneChecks
        }
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",for: indexPath) as! ItemTableViewCell
        
        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        
        let item: ToDoItem
        switch section {
        case .ToDo:
            item = itemManager.itemAtIndex(index: indexPath.row)
        case .Done:
            item = itemManager.doneItemAtIndex(index: indexPath.row)
        }
        
        cell.configCellWithItem(item: item)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        
        let buttonTitle: String
        switch section {
        case .ToDo:
            buttonTitle = "Check"
        case .Done:
            buttonTitle = "Uncheck"
        }
        
        return buttonTitle
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        
        switch section {
        case .ToDo:
            itemManager.checkItemAtIndex(index: indexPath.row)
        case .Done:
            itemManager.uncheckItemAtIndex(index: indexPath.row)
        }
        tableView.reloadData()
        
        
    }
  
    
    
    

}

enum Section: Int {
    case ToDo
    case Done
}
