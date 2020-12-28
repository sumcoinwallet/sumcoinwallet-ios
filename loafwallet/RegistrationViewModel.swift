//
//  RegistrationViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/24/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import SwiftUI

enum UserDataType {
    case genericString
    case email
    case country
    case mobileNumber
    case password
    case confirmation
}

class RegistrationViewModel: ObservableObject {
    
    @Published
    var isRegistering: Bool = false
 
    var dataDictionary = [String: Any]()
    
    init() {
        
    }
    
    func verify(data: [String: Any],
                  completion: @escaping (Bool) -> ()) {
        
        if  isDataValid(dataType: .genericString, data: (dataDictionary["firstName"] as! String)) &&
            isDataValid(dataType: .genericString, data: (dataDictionary["lastName"] as! String)) &&
            isDataValid(dataType: .password, data: (dataDictionary["password"] as! String)) &&
            isDataValid(dataType: .confirmation, firstString: (dataDictionary["password"] as! String),
                            data: (dataDictionary["confirmPassword"] as! String)) &&
            isDataValid(dataType: .mobileNumber, data: (dataDictionary["mobileNumber"] as! String)) &&
            isDataValid(dataType: .country, data: (dataDictionary["country"] as! String)) &&
            isDataValid(dataType: .genericString, data: (dataDictionary["state"] as! String)) &&
            isDataValid(dataType: .genericString, data: (dataDictionary["city"] as! String)) &&
            isDataValid(dataType: .genericString, data: (dataDictionary["address"] as! String)) &&
            isDataValid(dataType: .genericString, data: (dataDictionary["postCode"] as! String)) {
            
            self.isRegistering = true
            
            completion(isRegistering)
        }
        
        //DEV: REMOVE this is for testing
        self.isRegistering = true
        print(self.isRegistering)
        completion(self.isRegistering)
        //DEV: REMOVE this is for testing
        //DEV: REMOVE this is for testing
    }
    
    func register() {
        
//        // Prepare a credential for a token response
//        let credentials = ["email":emailString,
//                           "password": passwordString,
//                           "recaptcha_token": ""]
//
//
//        // Load Enum of the login credentials
//        let cardCredentials = LoginCredentials(email: emailString, password: passwordString)
//        let serverURL = "com.partnerapi.card"
//
//        let email = cardCredentials.email
//        guard let password = cardCredentials.password.data(using: String.Encoding.utf8) else { return }
//        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
//                                    kSecAttrAccount as String: email,
//                                    kSecAttrServer as String: serverURL,
//                                    kSecValueData as String: password]
//
//        let status = SecItemAdd(query as CFDictionary, nil)
//        if status != errSecSuccess  {
//            print("Error: \(KeychainError.unhandledError(status: status))")
//        }
        
        
        
        //DEV: Real Dict: self.dataDictionary
        
        
        let mockUser = PartnerAPI.shared.randomAddressDict()
        PartnerAPI.shared.createUser(userDataParams: mockUser ) { (newUser) in
            //
            print(newUser)
        }
    }
    
    func isDataValid(dataType: UserDataType, firstString: String = "", data: Any) -> Bool {
         
        switch dataType {
            case .genericString:
                return isGenericStringValid(genericString: (data as! String))
            case .email:
                return isEmailValid(emailString: (data as! String))
            case .country:
                return (data as! String) == "US" ?  true : false
            case .mobileNumber:
                return isMobileNumberValid(mobileString: (data as! String))
            case .password:
                return isPasswordValid(passwordString: (data as! String))
            case .confirmation:
                return isConfirmedValid(firstString: firstString, confirmingString: (data as! String))
        }
    }
    
    //MARK: - Data Validators
    
    func isGenericStringValid(genericString: String) -> Bool {
       
        guard genericString != "" else {
            return false
        }
        
        guard genericString.count <= 32 else {
            return false
        }
        
        return true
    }
    
    func isConfirmedValid(firstString: String, confirmingString: String) -> Bool {
        return firstString == confirmingString ? true : false
    }
    
    func isEmailValid(emailString: String) -> Bool {
           
        if try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive)
            .firstMatch(in: emailString, options: [],
                        range: NSRange(location: 0,
                        length: emailString.count)) == nil {
           return false
        } else {
            return true
        }
    }
    
    /// Password  Validator
    /// - Parameter passwordString: 6 - 10 chars
    /// - Returns: Bool
   func isPasswordValid(passwordString: String) -> Bool {
        
        guard passwordString != "" else {
            return false
        }
        
        guard (passwordString.count >= 6 && passwordString.count <= 10) else {
            return false
        }
        
        if try! NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$", options: .caseInsensitive)
            .firstMatch(in: passwordString, options: [],
                        range: NSRange(location: 0,
                                       length: passwordString.count)) == nil {
            return false
        } else {
            return true
        }
    }
     
    /// Mobile Number Validator
    /// - Parameter mobileString: 10+ integers 0 - 9
    /// - Returns: Bool
    func isMobileNumberValid(mobileString: String) -> Bool {
        guard mobileString != "" else {
            return false
        }
        
        //https://boards.straightdope.com/t/longest-telephone-number-in-the-world/400450
        guard (mobileString.count >= 10 && mobileString.count <= 20) else {
            return false
        }
        
        if try! NSRegularExpression(pattern: "^[0-9]*$", options: .caseInsensitive)
            .firstMatch(in: mobileString, options: [],
                        range: NSRange(location: 0,
                                       length: mobileString.count)) == nil {
            return false
        } else {
            return true
        }
    }
}
 
