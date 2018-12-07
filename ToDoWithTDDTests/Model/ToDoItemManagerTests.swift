//
//  ItemManagerTests.swift
//  ToDoWithTDDTests
//
//  Created by Manikanta Nandam on 03/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import XCTest
@testable import ToDoWithTDD
class ToDoItemManagerTests: XCTestCase {
    
    var sut: ToDoItemManager!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ToDoItemManager()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testToDoCount_Initially_ShouldBeZero(){
        XCTAssertEqual(sut.todoCount, 0, "Initially Count should be zero")
    }
    
    func testDoneChecks_Initially_ShouldBeZero(){
        XCTAssertEqual(sut.doneChecks, 0, "Initially Count should be zero")
    }
    
    func testToDo_AfterAddingOneItem_countShouldBeOne(){
        sut.addItem(todoItem: ToDoItem(title: "First Item"))
        XCTAssertEqual(sut.todoCount, 1, "After Adding One Item Count should be 1")
    }

    func testItemAtIndex_ShouldReturnPreviouslyAddedItem(){
        let todoItem = ToDoItem(title: "First Item")
        sut.addItem(todoItem: todoItem)
        let returnedItem = sut.itemAtIndex(index: 0)
        XCTAssertEqual(returnedItem.title, "First Item")
    
    }
    
    func testCheckItemAtIndex_ChangesCountOfTodoAndOfDoneChecks(){
        sut.addItem(todoItem: ToDoItem(title: "First Item"))
        sut.checkItemAtIndex(index: 0)
        
        XCTAssertEqual(sut.doneChecks, 1)
        XCTAssertEqual(sut.todoCount, 0)
        
    }
    func testCheckingItem_removingItFromTheToDoItem(){
        sut.addItem(todoItem: ToDoItem(title: "First Item"))
        sut.addItem(todoItem: ToDoItem(title: "Second Item"))
        sut.checkItemAtIndex(index: 0)
        
        XCTAssertEqual(sut.itemAtIndex(index: 0).title, "Second Item")
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem(){
        let item = ToDoItem(title: "First Item")
        sut.addItem(todoItem: item)
        sut.checkItemAtIndex(index: 0)
        
        let returnedItem = sut.doneItemAtIndex(index: 0)
        
        XCTAssertEqual(item.title, returnedItem.title, "Should be the same item")
    }

}
