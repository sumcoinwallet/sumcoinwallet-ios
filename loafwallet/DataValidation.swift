//
//  DataValidation.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/28/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation

enum ValidatorType {
    case email
    case genericString
    case password
    case mobileNumber
    case requiredField(field: String)
}
 
protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

class DataValidation {
      
}

struct ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
            case .genericString: return GenericStringValidator()
            case .email: return EmailValidator()
            case .password: return PasswordValidator()
            case .mobileNumber: return MobileNumberValidator()
            case let .requiredField(fieldName): return RequiredFieldValidator(fieldName)
        }
    }
}
 
struct GenericStringValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else { throw ValidationError("Must not be empty") }
        return value
    }
}

struct MobileNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else { throw ValidationError("Mobile number is required") }
        guard value.count >= 10 else { throw ValidationError("Mobile number must have at least 10 digits") }
        
        do {
            if try NSRegularExpression(pattern: "^[0-9]*$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Mobile number must only have digits")
            }
        } catch {
            throw ValidationError("Mobile number must only have digits")
        }
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value != "" else { throw ValidationError("Password is Required") }
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}
