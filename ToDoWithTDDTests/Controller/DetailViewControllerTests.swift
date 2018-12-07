//
//  DetailViewControllerTests.swift
//  ToDoWithTDDTests
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import XCTest
@testable import ToDoWithTDD
import CoreLocation

class DetailViewControllerTests: XCTestCase {

    var sut: DetailsViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "DetailsViewController") as? DetailsViewController
        
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HasTitleLabel() {
        
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasDescriptionLabel(){
        XCTAssertNotNil(sut.descriptionLabel)
    }

    func test_HasLocationLabel(){
        XCTAssertNotNil(sut.locationLabel)
    }

    func test_HasDateLabel(){
        XCTAssertNotNil(sut.dateLabel)
    }

    func test_HasMapView(){
         XCTAssertNotNil(sut.mapView)
    }
    
    func test_hasCheckButton(){
        XCTAssertNotNil(sut.checkButton)
    }
    
    func testCheckButton_titleShouldBeCheck(){
                XCTAssertEqual(sut.checkButton.title(for: .normal), "Check")

    }
    
    func testSettingItemInfo_SetsTextsToLabels() {
        
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277,
                                                longitude: 6.7735)
        
        let itemManager = ToDoItemManager()
        itemManager.addItem(todoItem: ToDoItem(title: "The title",
                                     itemDescription: "The description",
                                     timeStamp: 1456150025,
                                     location: Location(name: "Home", coordinate: coordinate)))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "The title")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Home")
        XCTAssertEqual(sut.descriptionLabel.text, "The description")
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                                   coordinate.latitude,
                                   accuracy: 0.001)
        
        
    }
    
    func testCheckItem_ChecksItemInItemManager() {
        
        let itemManager = ToDoItemManager()
        itemManager.addItem(todoItem: ToDoItem(title: "The title"))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.checkItem()
        
        XCTAssertEqual(itemManager.todoCount, 0)
        XCTAssertEqual(itemManager.doneChecks, 1)
    }
}
