//
//  Setting.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2017-04-01.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import Foundation

struct Setting {
    let title: String
    let accessoryText: (() -> String)?
    let callback: () -> Void
}

extension Setting {
    init(title: String, callback: @escaping () -> Void) {
        self.title = title
        self.accessoryText = nil
        self.callback = callback
    }
}
