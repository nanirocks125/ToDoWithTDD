//
//  ToDoItemTests.swift
//  ToDoWithTDDTests
//
//  Created by Manikanta Nandam on 03/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import XCTest
@testable import ToDoWithTDD

class ToDoItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit_ShouldTakeTitle(){
        let todoItem = ToDoItem(title: "Test Title")
        XCTAssertNotNil(todoItem, "Item should not be nil")

    }
    
    func testInitShouldSetTitleAndDescription(){
        let todoItem = ToDoItem(title: "Test Title",itemDescription: "Test Description")
        XCTAssertNotNil(todoItem, "Item should not be nil")
        XCTAssertEqual(todoItem.title, "Test Title")
        XCTAssertEqual(todoItem.itemDescription, "Test Description")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimeStamp(){
        let todoItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timeStamp: 0.0)
        
        XCTAssertEqual(todoItem.timeStamp, 0.0)
    }
    
    func testinit_ShouldSetTitleAndDescriptionAndTimeStampAndLocation(){
        let location = Location(name: "Test Location")
        let todoItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timeStamp: 0.0, location: location)
        XCTAssertEqual(location.name, "Test Location")
        XCTAssertEqual(todoItem.location?.name, location.name)
        
        
    }
    
    func testEqualItems_ShouldBeEqual(){
        let firstItem = ToDoItem(title: "First Item")
        let secondItem = ToDoItem(title: "First Item")
        
        XCTAssertEqual(firstItem, secondItem)

    }
    
    func testWhenLocationDiffers_ShouldNotBeEqual(){
        let firstItem = ToDoItem(title: "First title",
                                  itemDescription: "First description",
                                  timeStamp: 0.0,
                                  location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title",
                                  itemDescription: "First description",
                                  timeStamp: 0.0,
                                  location: Location(name: "Office"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }



}
