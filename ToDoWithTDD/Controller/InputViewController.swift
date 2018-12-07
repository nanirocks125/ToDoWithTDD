//
//  InputViewController.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    
    lazy var geocoder = CLGeocoder()
    var itemManager: ToDoItemManager?
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func save(_ sender: Any) {

        guard let titleString = titleTextField.text, titleString.count > 0 else { return }
        let date: Date?
        if let dateText = self.dateTextField.text, dateText.count > 0 {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        
        
        let descriptionString: String?
        if let description = descriptionTextField.text?.count,description > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        if let locationName = locationTextField.text, locationName.count > 0 {
            if let address = addressTextField.text, address.count > 0 {
                
                geocoder.geocodeAddressString(address) {
                    [unowned self] (placeMarks, error) -> Void in
                    
                    let placeMark = placeMarks?.first
                    
                    let item = ToDoItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timeStamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName,
                                                           coordinate: placeMark?.location?.coordinate))
                    
                    self.itemManager?.addItem(todoItem: item)
                }
            }
        }
    }

}
