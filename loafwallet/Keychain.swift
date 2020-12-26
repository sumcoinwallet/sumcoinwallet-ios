//
//  Keychain.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/27/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

struct LoginCredentials {
    var email: String
    var password: String
}
