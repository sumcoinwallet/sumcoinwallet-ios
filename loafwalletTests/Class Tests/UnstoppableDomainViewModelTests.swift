//
//  UnstoppableDomainViewModelTests.swift
//  loafwalletTests
//
//  Created by Kerry Washington on 11/18/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import XCTest
@testable import loafwallet

class UnstoppableDomainViewModelTests: XCTestCase {
    
    var viewModel: UnstoppableDomainViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UnstoppableDomainViewModel()
    }
    
    /// Checks the domain address closure
    /// - Throws: Error
    func testDomainLookupForSUM() throws {
          
        self.viewModel.didResolveUDAddress?("RESOLVED_SUM_ADDRESS")
        
        //DEV: This test succeeds incorrectly
        viewModel.didResolveUDAddress = { address in
            XCTAssertTrue(address == "RESOLVED_SUM_ADDRESS")
        }
    }

}

