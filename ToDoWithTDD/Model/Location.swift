//
//  Location.swift
//  ToDoWithTDD
//
//  Created by Manikanta Nandam on 03/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs.coordinate?.latitude != rhs.coordinate?.latitude{
            return false
        }

        if lhs.coordinate?.longitude != rhs.coordinate?.longitude {
            return false
        }
        
        return true
    }
    
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil){
        self.name = name
        self.coordinate = coordinate
    }
}
