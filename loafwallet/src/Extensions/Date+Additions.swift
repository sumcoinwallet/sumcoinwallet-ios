//
//  Date+Additions.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2017-06-09.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import Foundation

extension Date {
    func hasEqualYear(_ date: Date) -> Bool {
        return Calendar.current.compare(self, to: date, toGranularity: .year) == .orderedSame
    }

    func hasEqualMonth(_ date: Date) -> Bool {
        return Calendar.current.compare(self, to: date, toGranularity: .month) == .orderedSame
    }
}
