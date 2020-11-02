//
//  UnstoppableDomainsTests.swift
//  Created by Johnny Good on 8/11/20
  
import XCTest
import UnstoppableDomainsResolution
@testable import loafwallet


class UnstoppableDomainsTests: XCTestCase {
    
    let timeout: TimeInterval = 10
    
    var resolution: Resolution!
    
    var addressCell = AddressCell()

    override func setUp() {
        super.setUp()
        resolution = try! Resolution(providerUrl: "https://main-rpc.linkpool.io", network: "mainnet")
    }
    
    func testLTCAddressResolved() throws {
        //ihatefiat.crypto
        //BTC 1HMugYDr83APw8zY8DKKTK7Y6b1eF8C89J
        //ETH 0x1e02a008A5ee37Bbf46026D7B87a599f27389e38
        //LStezbCm4YHZut45C4GJrbhHq2H9oz2Q4U
        
//        XCTAssertTrue(addressCell.fetchUDResolution(ltcString: "ihatefiat.crypto") == "LStezbCm4YHZut45C4GJrbhHq2H9oz2Q4U")
    }
    
//    private func fetchUDResolution(ltcString: String) -> String {
//
//        guard let resolution = try? Resolution() else {
//            print ("Init of Resolution instance with default parameters failed...")
//            return ""
//        }
//
//        var resultString = ltcString
//
//        resolution.addr(domain: ltcString, ticker: "ltc") { result in
//            switch result {
//            case .success(let returnValue):
//                resultString = returnValue
//            case .failure(let error):
//                print("Expected LTC Address, but got \(error)")
//            }
//        }
//
//        return resultString
//
//    }
    
    
  
}

extension ResolutionError: Equatable {
    public static func == (lhs: ResolutionError, rhs: ResolutionError) -> Bool {
        switch (lhs, rhs) {
        case ( .unregisteredDomain, .unregisteredDomain):
            return true
        case ( .unsupportedDomain, .unsupportedDomain):
            return true
        case ( .recordNotFound, .recordNotFound):
            return true
        case ( .recordNotSupported, .recordNotSupported):
            return true
        case ( .unsupportedNetwork, .unsupportedNetwork):
            return true
        case (.unspecifiedResolver, .unspecifiedResolver):
            return true
        case (.proxyReaderNonInitialized, .proxyReaderNonInitialized):
            return true
        case (.inconsistenDomainArray, .inconsistenDomainArray):
            return true
        case (.methodNotSupported, .methodNotSupported):
            return true
        // We don't use `default` here on purpose, so we don't forget updating this method on adding new variants.
        case (.unregisteredDomain, _),
             (.unsupportedDomain, _),
             (.recordNotFound, _),
             (.recordNotSupported, _),
             (.unsupportedNetwork, _),
             (.unspecifiedResolver, _),
             (.unknownError, _ ),
             (.inconsistenDomainArray, _),
             (.methodNotSupported, _),
             (.proxyReaderNonInitialized, _):
            
            return false
        }
    }
}



