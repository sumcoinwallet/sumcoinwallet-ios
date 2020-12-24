//
//  AnimatedCardViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import UIKit

class AnimatedCardViewModel: ObservableObject {
     
    @Published
    var rotateIn3D = false
    
    var dropOffset: CGFloat = -200.0
    
    
    @Published
    var imageFront = "litecoin-card-front"
    
    @Published
    var imageBack = "litecoin-card-back"

    
     init() {
        
     }
}
