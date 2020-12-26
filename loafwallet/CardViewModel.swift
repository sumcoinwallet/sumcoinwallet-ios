//
//  CardViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import SwiftUI
import Security

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
                
        //DEV: The captcha is not support at this time
        
        
        // Prepare a credential for a token response
        let credentials = ["email":emailString,
                     "password": passwordString,
                     "recaptcha_token": ""]
        
        
        // Load Enum of the login credentials
        let cardCredentials = LoginCredentials(email: emailString, password: passwordString)
        let serverURL = "com.partnerapi.card"
        
        let email = cardCredentials.email
        guard let password = cardCredentials.password.data(using: String.Encoding.utf8) else { return }
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: email,
                                    kSecAttrServer as String: serverURL,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess  {
            print("Error: \(KeychainError.unhandledError(status: status))")
         }
         
        PartnerAPI.shared.loginUser(credentials: credentials) { dataDictionary in
            
            if let token = dataDictionary?["token"] {
                
                //Save into the keychain
                
                
            }
            
        }
    }
    
}
