//
//  InputViewControllerTests.swift
//  ToDoWithTDDTests
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import XCTest
@testable import ToDoWithTDD
import CoreLocation

class InputViewControllerTests: XCTestCase {
        var sut: InputViewController!
    var placemark: MockPlacemark!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "InputViewController") as? InputViewController
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HasAllTextFieldsAndButtons(){
        
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.dateTextField)
        XCTAssertNotNil(sut.locationTextField)
        XCTAssertNotNil(sut.addressTextField)
        XCTAssertNotNil(sut.descriptionTextField)
        XCTAssertNotNil(sut.saveButton)
        XCTAssertNotNil(sut.cancelButton)

    }
    
    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ToDoItemManager()
        
        sut.save(sut.saveButton)
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851,
                                                    -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.itemAtIndex(index: 0)
        
        let testItem = ToDoItem(title: "Test Title",
                                itemDescription: "Test Description",
                                timeStamp: 1456095600,
                                location: Location(name: "Office", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        
        guard let actions = saveButton.actions(forTarget: sut,
                                               forControlEvent: .touchUpInside) else {
                                                XCTFail(); return
        }
        print(actions.contains("save"))
        XCTAssertTrue(actions.contains("save:"))
    }
    
    func test_GeocoderWorksAsExpected() {
        let expectation = self.expectation(description: "myExpectation")
        
        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertino") {
            (placemarks, error) -> Void in
            let placemark = placemarks?.first
            
            let coordinate = placemark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return
            }
            
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return
            }

           
            
            XCTAssertEqual(latitude, 37.3316883,
                                       accuracy: 0.000001)
            XCTAssertEqual(longitude, -122.0301707,
                                       accuracy: 0.000001)
            expectation.fulfill()
            
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    

}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
        
    }
    
    class MockPlacemark : CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else
            { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude,
                              longitude: coordinate.longitude)
        }
    }
}
