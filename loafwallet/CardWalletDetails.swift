//
//  CardWalletDetails.swift
//  loafwallet
//
//  Created by Kerry Washington on 3/29/21.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import Foundation

struct CardWalletDetails: Decodable {

    var balance: Float?
    var sumAddress: String?
    var createdAt: String?
    var updatedAt: String?
    var availableBalance: Float?
    var withdrawableBalance: Float?
    var spendableBalance: Float?

    enum CodingKeys: String, CodingKey {
        case balance = "balance"
        case sumAddress = "sum_address"
        case createdAt = "created_at"
        case updatedAt  = "updated_at"
        case availableBalance = "available_balance"
        case withdrawableBalance = "withdrawable_balance"
        case spendableBalance = "spendable_balance"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        balance = try? container.decode(Float.self, forKey: .balance)
        sumAddress = try? container.decode(String.self, forKey: .sumAddress)
        createdAt = try? container.decode(String.self, forKey: .createdAt)
        updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        availableBalance = try? container.decode(Float.self, forKey: .availableBalance)
        withdrawableBalance = try? container.decode(Float.self, forKey: .withdrawableBalance)
        spendableBalance = try? container.decode(Float.self, forKey: .spendableBalance)
    }
}
