//
//  ModalDisplayable.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2016-12-01.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import UIKit

protocol ModalDisplayable {
    var modalTitle: String { get }
    var faqArticleId: String? { get }
}

protocol ModalPresentable {
    var parentView: UIView? { get set }
}
