//
//  ConstantsTests.swift
//  loafwalletTests
//
//  Created by Kerry Washington on 11/14/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import XCTest
@testable import loafwallet
 
class ConstantsTests: XCTestCase {
 
    func testLFDonationAddressPage() throws {
        XCTAssertTrue(FoundationSupport.url.absoluteString == "https://lite-wallet.org/support_address.html" )
	}
}
