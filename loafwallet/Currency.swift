//
//  Currency.swift
//  breadwallet
//
//  Created by Kerry Washington on 10/2/18.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import Foundation
import UIKit

class Currency {
    
    class func getSymbolForCurrencyCode(code: String) -> String? {
        let result = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == code }
        return result?.currencySymbol
    }
}

enum PartnerFiatOptions: Int, CustomStringConvertible {
    case cad
    case aud
    case idr
    case rub
    case jpy
    case eur
    case gbp
    case usd
    
    public var description: String {
        return code
    }
    
    private var code: String {
        switch self {
            case .cad: return "CAD"
            case .aud: return "AUD"
            case .idr: return "IDR"
            case .rub: return "RUB"
            case .jpy: return "JPY"
            case .eur: return "EUR"
            case .gbp: return "GBP"
            case .usd: return "USD"
        }
    }
    
    public var index: Int {
        switch self {
            case .cad: return 0
            case .aud: return 1
            case .idr: return 2
            case .rub: return 3
            case .jpy: return 4
            case .eur: return 5
            case .gbp: return 6
            case .usd: return 7
        }
    }
}

