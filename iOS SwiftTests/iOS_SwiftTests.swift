//
//  iOS_SwiftTests.swift
//  iOS SwiftTests
//
//  Created by Ivica Petrsoric on 13/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import XCTest
@testable import iOS_Swift

class MockDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        completion([User(id: 1, name: "Kilo Loco")])
    }
}

class iOS_SwiftTests: XCTestCase {
    
    var sot: StartView.ViewModel!

    override func setUpWithError() throws {
        sot = StartView.ViewModel(dataService: MockDataService())
    }

    override func tearDownWithError() throws {
        sot = nil
    }
    
    func test_getUsers() throws {
        XCTAssertTrue(sot.users.isEmpty)
        
        sot.getUsers()
        
        XCTAssertEqual(sot.users.count, 1)
    }


}
