//
//  ForgotAlertViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 4/1/21.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import Foundation
import SwiftUI
import Sumcoin WalletPartnerAPI

class ForgotAlertViewModel: ObservableObject {
    
    //MARK: - Combine Variables
    @Published
    var emailString: String = ""
    
    @Published
    var detailMessage: String = S.SumcoinCard.resetPasswordDetail
    
    init() { }
    
    func resetPassword(completion: @escaping () -> Void) {
        
        PartnerAPI.shared.forgotPassword(email: emailString) { (responseMessage, code) in
             
            DispatchQueue.main.async {
                self.detailMessage = "\(code): " + responseMessage
                completion()
            }
        }
    }
    
    func shouldDismissView(completion: @escaping () -> Void) {
        completion()
    }
}

