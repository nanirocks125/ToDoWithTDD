//
//  ItemListViewController.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet var dataProvider:  (UITableViewDataSource & UITableViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        // Do any additional setup after loading the view.
    }
    

}
