//
//  SupportSumcoinWalletViewModelTests.swift
//  loafwalletTests
//
//  Created by Kerry Washington on 11/16/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import XCTest
@testable import loafwallet

class SupportSumcoinWalletViewModelTests: XCTestCase {
      
    var viewModel: SupportSumcoinWalletViewModel!
      
    override func setUp() {
        super.setUp()
        viewModel = SupportSumcoinWalletViewModel()
    }
     
    /// Checks the user taps on the closure
    func testDidTapToDismiss() throws {
        
        self.viewModel.didTapToDismiss?()
  
        viewModel.didTapToDismiss = {
            XCTAssert(true, "Tap did work")
        }
    }
    
}
