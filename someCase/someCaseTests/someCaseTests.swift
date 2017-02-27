//
//  someCaseTests.swift
//  someCaseTests
//
//  Created by licong on 2017/2/21.
//  Copyright © 2017年 Richard. All rights reserved.
//

import XCTest
@testable import someCase

class someCaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmpty() {
        
        let empty = [Any]()
        let originArray = [[empty],empty] as [Any]
        let iterator = Iterator(array: originArray)
        XCTAssertEqual(nil, iterator.next())
        XCTAssertEqual(nil, iterator.next())

    }
    
    func testCase() {
        let originArray = [2,[5,8],6] as [Any]
        let iterator = Iterator(array: originArray)
        XCTAssertEqual(2, iterator.next())
        XCTAssertEqual(5, iterator.next())
        XCTAssertEqual(8, iterator.next())
        XCTAssertEqual(6, iterator.next())

    }
    
    func testDictionary() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
