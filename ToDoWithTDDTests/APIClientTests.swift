//
//  APIClientTests.swift
//  ToDoWithTDDTests
//
//  Created by Manikanta Nandam on 04/12/18.
//  Copyright © 2018 Manikanta. All rights reserved.
//

import XCTest
@testable import ToDoWithTDD

class APIClientTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin_MakesRequestWithUsernameAndPassword() {
        let sut = APIClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
        let completion = { (error: Error?) in }
        
        sut.loginUserWithName(username: "dasdom",
                              password: "%&34",
                              completion: completion)
        
        guard let url = mockURLSession.url else { XCTFail(); return }
        let urlComponents = NSURLComponents(url: url,
                                            resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
         XCTAssertEqual(urlComponents?.path, "/login")
        let allowedCharacters = NSCharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let expectedUsername = "dasdom".addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        guard let expectedPassword = "%&34".addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        XCTAssertEqual(urlComponents?.percentEncodedQuery,
                       "username=\(expectedUsername)&password=\(expectedPassword)")

    }
    
//    func testLogin_CallsResumeOfDataTask() {
//        let sut = APIClient()
//        
//        let mockURLSession = MockURLSession()
//        sut.session = mockURLSession
//        let completion = { (error: Error?) in }
//        sut.loginUserWithName(username: "dasdom",
//                              password: "1234",
//                              completion: completion)
//        
//        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
//    }

}

extension APIClientTests {
    
    class MockURLSession: ToDoURLSession {
        
        typealias Handler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: Handler?
        var url: URL?
         var dataTask = MockURLSessionDataTask()


        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask{
            self.url = url
            self.completionHandler = completionHandler
            return dataTask
        }
        
        
        
    }
    class MockURLSessionDataTask : URLSessionDataTask {
        var resumeGotCalled = false
        
        override func resume() {
            resumeGotCalled = true
        }
    }
}
