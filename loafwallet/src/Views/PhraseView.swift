//
//  PhraseView.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2016-10-26.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import UIKit

class PhraseView: UIView {

    private let phrase: String
    private let label = UILabel()

    static let defaultSize = CGSize(width: 200, height: 88.0)

    var xConstraint: NSLayoutConstraint?

    init(phrase: String) {
        self.phrase = phrase
        super.init(frame: CGRect())
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(label)
        label.constrainToCenter()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = phrase
        label.font = UIFont.customBold(size: 30.0)
        backgroundColor = .sumcoinWalletBlue
        layer.cornerRadius = 10.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
