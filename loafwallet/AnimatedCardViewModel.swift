//
//  AnimatedCardViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import Foundation
import UIKit

class AnimatedCardViewModel: ObservableObject {
     
    @Published
    var rotateIn3D = false
     
    @Published
    var isLoggedIn = false
    
    @Published
    var imageFront = "sumcoin-card-front"
    
    var dropOffset: CGFloat = -200.0
     
    init() { }
}
