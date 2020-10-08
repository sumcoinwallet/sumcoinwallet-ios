//
//  BuyWKWebVCTests.swift
//  loafwalletTests
//
//  Created by Kerry Washington on 12/20/19.
//  Copyright © 2019 Litecoin Foundation. All rights reserved.
//

import XCTest
@testable import Litewallet

class BuyWKWebVCTests: XCTestCase {

    func testUUIDStringExists() {
        XCTAssert(UIDevice.current.identifierForVendor?.uuidString != "")
    }

}
