//
//  NonScrollingCollectionView.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2017-02-28.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import UIKit

//This class disables all scrolling. This is desired
//when we don't want the scrollView to scroll to the active
//textField
class NonScrollingCollectionView : UICollectionView {
    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        //noop
    }
}
