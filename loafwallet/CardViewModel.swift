//
//  CardViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import SwiftUI

class CardViewModel: ObservableObject {
    
    @Published
    var emailString: String = ""
    
    @Published
    var passwordString: String = ""
    
    @Published
    var isNotRegistered: Bool = true
    
    init() {
        
    }
    
    func login(completion: @escaping (Bool) -> ()) {
        
         
         completion(true)
    }
    
    
    
}
