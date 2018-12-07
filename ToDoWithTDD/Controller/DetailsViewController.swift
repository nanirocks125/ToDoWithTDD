//
//  DetailsViewController.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    var itemInfo: (ToDoItemManager, Int)?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let itemInfo = itemInfo else { return }
        let item = itemInfo.0.itemAtIndex(index: itemInfo.1)
        
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        descriptionLabel.text = item.itemDescription
        
        if let timestamp = item.timeStamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(for: date)
        }
        
        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.region = region
        }
    }
    
    func checkItem(){
        if let itemInfo = itemInfo {
            itemInfo.0.checkItemAtIndex(index: itemInfo.1)
        }
    }

}
