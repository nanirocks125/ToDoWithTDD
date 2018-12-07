//
//  LocationTests.swift
//  ToDoWithTDDTests
//
//  Created by Manikanta Nandam on 03/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import XCTest
@testable import ToDoWithTDD
import CoreLocation

class LocationTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit_ShouldSetName(){
        let location = Location(name: "Test Location")
        XCTAssertEqual(location.name, "Test Location")
    }
    
    func testInit_ShouldSetNameAndCoordinate(){
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Test Location", coordinate: testCoordinate)
        XCTAssertEqual(location.coordinate?.latitude, 1)
        XCTAssertEqual(location.coordinate?.latitude, testCoordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, 2)
        XCTAssertEqual(location.coordinate?.longitude, testCoordinate.longitude)
        
    }
    
    func testEqualLocations_ShouldBeEqual(){
        let location1 = Location(name: "First Location")
        let location2 = Location(name: "First Location")
        XCTAssertEqual(location1, location2)
    }
    
    func testWhenLatitudeDiffers_ShouldNotBeEqual(){

        performNotEqualTestsWithLocationProperties(firstName: "Location 1", secondName: "Location 2", firstCordinate: (lat: 1, long: 0), secondCordinate: (lat: 2, long: 0), line: #line)
        
    }
    
    func testWhenLogitudeDiffers_ShouldNotBeEqual(){

        
        performNotEqualTestsWithLocationProperties(firstName: "Location 1", secondName: "Location 2", firstCordinate: (lat: 1, long: 0), secondCordinate: (lat: 1, long: 2), line: #line)
    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual() {

        performNotEqualTestsWithLocationProperties(firstName: "Home", secondName: "Home", firstCordinate: (lat: 0.0, long: 0.0), secondCordinate: nil, line: #line)
    }
    
    func performNotEqualTestsWithLocationProperties(firstName: String, secondName: String, firstCordinate: (lat: Double, long: Double)?, secondCordinate: (lat: Double, long: Double)?, line: UInt){
        
        let firstCord: CLLocationCoordinate2D?
        let secondCord: CLLocationCoordinate2D?
        if let firstCordinate = firstCordinate{
            firstCord = CLLocationCoordinate2D(latitude: firstCordinate.lat, longitude: firstCordinate.long)
        }else{
            firstCord = nil
        }
        
        if let secondCordinate = secondCordinate{
            secondCord = CLLocationCoordinate2D(latitude: secondCordinate.lat, longitude: secondCordinate.long)
        }else{
            secondCord = nil
        }
        
        
        let firstLocation = Location(name: firstName, coordinate: firstCord)
        let secondLocation = Location(name: secondName, coordinate: secondCord)
        XCTAssertNotEqual(firstLocation, secondLocation,line: line)
    }
    
}

