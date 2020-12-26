//
//  View+Extension.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/26/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    
    func loginAlertView(isShowingLogin: Binding<Bool>,
                        message: String) -> some View {
        loafwallet.LoginCardAlertView(isShowingLogin: isShowingLogin,
                       presenting: self,
                       mainMessage: message)
    }
    
    func forgotPasswordView(isShowingForgot: Binding<Bool>,
                            emailString: Binding<String>,
                            message: String) -> some View {
        loafwallet.ForgotAlertView(isShowingForgot: isShowingForgot,
                                   emailString: emailString,
                                   presenting: self,
                                   mainMessage: message)
    }
    
}
 
