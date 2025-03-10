//
//  UIScreen+Additions.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2017-09-28.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import UIKit

extension UIScreen {
    var safeWidth: CGFloat {
        return min(bounds.width, bounds.height)
    }
}
