//
//  Keychain.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/27/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import KeychainAccess

//enum KeychainError: Error {
//    case noPassword
//    case unexpectedPasswordData
//    case unhandledError(status: OSStatus)
//}

//
//class KeychainAccessManager: NSObject {
//
//    static let shared = KeychainAccessManager()
//
//    private let cardServiceName = "com.litecoincard.service"
//
//    override init() {
//
//        s
//
//    }
//
//    addToken()
//}
//
//struct KeychainManagerError: Error {
//    var message: String?
//    var type: KeychainErrorType
//
//    enum KeychainErrorType {
//        case badData
//        case servicesError
//        case itemNotFound
//        case unableToConvertToString
//    }
//
//    init(status: OSStatus, type: KeychainErrorType) {
//        self.type = type
//        if let errorMessage = SecCopyErrorMessageString(status, nil) {
//            self.message = String(errorMessage)
//        } else {
//            self.message = "Status Code: \(status)"
//        }
//    }
//
//    init(type: KeychainErrorType) {
//        self.type = type
//    }
//
//    init(message: String, type: KeychainErrorType) {
//        self.message = message
//        self.type = type
//    }
//}
//
//struct LoginCredentials {
//    var email: String
//    var password: String
//}
//
//
//class KeychainManager {
//
//
//    /// Store the login information from Litecoin Card
//    /// - Parameters:
//    ///   - email: email address
//    ///   - password: verified password
//    ///   - userID: UUID from the 200 call
//    ///   - accessToken: JWT
//    ///   - service: URL
//    /// - Throws: no error expected
//
//    func storeLitecoinCardPasswordfor(password: String, email: String, userID: String,
//                                      accessToken: String, createdDateString: String, service: String) throws {
//        print("ERROR: Issue converting the value to data")
//
//            guard let passwordData = password.data(using: .utf8) else {
//                throw KeychainManagerError(message: "Error: Failed to convert password data", type: .badData)
//            }
//
//            let serviceURL = "com.partnerapi.card"
//
//            let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
//                                    kSecAttrAccount as String: email,
//                                    kSecAttrGeneric as String: userID,
//                                    kSecAttrTokenID as String: accessToken,
//                                    kSecValueData as String: passwordData,
//                                    kSecAttrCreationDate as String: createdDateString,
//                                    kSecAttrService as String: serviceURL]
//
//            let status = SecItemAdd(query as CFDictionary, nil)
//
//            switch status {
//                case errSecSuccess:
//                    break
//                default:
//                    throw KeychainManagerError(status: status, type: .servicesError)
//            }
//    }
//
//
//
//    func searchLitecoinCardPasswordFor(email: String, service: String) throws -> String {
//
//        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
//                                    kSecAttrAccount as String: email,
//                                    kSecAttrService as String: service,
//                                    kSecMatchLimit as String: kSecMatchLimitOne,
//                                    kSecReturnAttributes as String: true,
//                                    kSecReturnData as String: true]
//
//        var item: CFTypeRef?
//        let status = SecItemCopyMatching(query as CFDictionary, &item)
//
//        guard status != errSecItemNotFound else {
//            throw KeychainManagerError(type: .itemNotFound)
//        }
//
//        guard status == errSecSuccess else {
//            throw KeychainManagerError(status: status, type: .servicesError)
//        }
//
//        guard
//            let existingItem = item as? [String: Any],
//             let valueData = existingItem[kSecValueData as String] as? Data,
//             let value = String(data: valueData, encoding: .utf8)
//        else {
//             throw KeychainManagerError(type: .unableToConvertToString)
//        }
//
//        return value
//    }
//
//
//}
//
//
