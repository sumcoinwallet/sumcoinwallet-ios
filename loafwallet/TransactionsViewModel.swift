//
//  TransactionsViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/20/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    
    var store: Store
    
    var walletManager: WalletManager
    
    var isSUMSwapped: Bool  = false
      
    init(store: Store, walletManager: WalletManager) {
        
        self.store = store
        self.walletManager = walletManager
        self.isSUMSwapped = store.state.isSumSwapped
    }
}

