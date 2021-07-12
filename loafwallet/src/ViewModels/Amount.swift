//
//  Amount.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2017-01-15.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import Foundation

struct Amount {

    //MARK: - Public
    let amount: UInt64 //amount in satoshis
    let rate: Rate
    let maxDigits: Int

    var amountForSumFormat: Double {
        var decimal = Decimal(self.amount)
        var amount: Decimal = 0.0
        NSDecimalMultiplyByPowerOf10(&amount, &decimal, Int16(-maxDigits), .up)
        return NSDecimalNumber(decimal: amount).doubleValue
    }

    var localAmount: Double {
        return Double(amount)/100000000.0*rate.rate
    }

    var bits: String {
        var decimal = Decimal(self.amount)
        var amount: Decimal = 0.0
        NSDecimalMultiplyByPowerOf10(&amount, &decimal, Int16(-maxDigits), .up)
        let number = NSDecimalNumber(decimal: amount)
        guard let string = sumFormat.string(from: number) else { return "" }
        return string
    }

    var localCurrency: String {
        guard let string = localFormat.string(from: Double(amount)/100000000.0*rate.rate as NSNumber) else { return "" }
        return string
    }

    func string(forLocal local: Locale) -> String {
        let format = NumberFormatter()
        format.locale = local
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativePrefix = "-"
        guard let string = format.string(from: Double(amount)/100000000.0*rate.rate as NSNumber) else { return "" }
        return string
    }

    func string(isSumSwapped: Bool) -> String {
        return isSumSwapped ? localCurrency : bits
    }

    var sumFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativePrefix = "-"
        format.currencyCode = "SUM"

        switch maxDigits {
        case 2: // millisums
            format.currencySymbol = "m\(S.Symbols.sums)\(S.Symbols.narrowSpace)"
            format.maximum = (C.maxMoney/C.satoshis)*100000 as NSNumber
        case 5: // sums
            format.currencySymbol = "\(S.Symbols.sums)\(S.Symbols.narrowSpace)"
            format.maximum = (C.maxMoney/C.satoshis)*1000 as NSNumber
        case 8: // sumcoin
            format.currencySymbol = "\(S.Symbols.sum)\(S.Symbols.narrowSpace)"
            format.maximum = C.maxMoney/C.satoshis as NSNumber
        default:
            format.currencySymbol = "\(S.Symbols.sums)\(S.Symbols.narrowSpace)"
        }

        format.maximumFractionDigits = maxDigits
        format.minimumFractionDigits = 0 // iOS 8 bug, minimumFractionDigits now has to be set after currencySymbol
        format.maximum = Decimal(C.maxMoney)/(pow(10.0, maxDigits)) as NSNumber

        return format
    }

    var localFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativePrefix = "-"
        format.currencySymbol = rate.currencySymbol
        return format
    }
}

struct DisplayAmount {
    let amount: Satoshis
    let state: ReduxState
    let selectedRate: Rate?
    let minimumFractionDigits: Int?

    var description: String {
        return selectedRate != nil ? fiatDescription : sumcoinDescription
    }

    var combinedDescription: String {
        return state.isSumSwapped ? "\(fiatDescription) (\(sumcoinDescription))" : "\(sumcoinDescription) (\(fiatDescription))"
    }

    private var fiatDescription: String {
        guard let rate = selectedRate ?? state.currentRate else { return "" }
        guard let string = localFormat.string(from: Double(amount.rawValue)/100000000.0*rate.rate as NSNumber) else { return "" }
        return string
    }

    private var sumcoinDescription: String {
        var decimal = Decimal(self.amount.rawValue)
        var amount: Decimal = 0.0
        NSDecimalMultiplyByPowerOf10(&amount, &decimal, Int16(-state.maxDigits), .up)
        let number = NSDecimalNumber(decimal: amount)
        guard let string = sumFormat.string(from: number) else { return "" }
        return string
    }

    var localFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativePrefix = "-"
        if let rate = selectedRate {
            format.currencySymbol = rate.currencySymbol
        } else if let rate = state.currentRate {
            format.currencySymbol = rate.currencySymbol
        }
        if let minimumFractionDigits = minimumFractionDigits {
            format.minimumFractionDigits = minimumFractionDigits
        }
        return format
    }

    var sumFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativePrefix = "-"
        format.currencyCode = "SUM"

        switch state.maxDigits {
        case 2:
            format.currencySymbol = "m\(S.Symbols.sums)\(S.Symbols.narrowSpace)"
            format.maximum = (C.maxMoney/C.satoshis)*100000 as NSNumber
        case 5:
            format.currencySymbol = "\(S.Symbols.sums)\(S.Symbols.narrowSpace)"
            format.maximum = (C.maxMoney/C.satoshis)*1000 as NSNumber
        case 8:
            format.currencySymbol = "\(S.Symbols.sum)\(S.Symbols.narrowSpace)"
            format.maximum = C.maxMoney/C.satoshis as NSNumber
        default:
            format.currencySymbol = "\(S.Symbols.sums)\(S.Symbols.narrowSpace)"
        }

        format.maximumFractionDigits = state.maxDigits
        if let minimumFractionDigits = minimumFractionDigits {
            format.minimumFractionDigits = minimumFractionDigits
        }
        format.maximum = Decimal(C.maxMoney)/(pow(10.0, state.maxDigits)) as NSNumber

        return format
    }
}
