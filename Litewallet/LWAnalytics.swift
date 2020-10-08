//
//  Analytics.swift
//  loafwallet
//
//  Created by Kerry Washington on 2/15/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import FirebaseAnalytics

/// Litewallet Analytics helper composes and sends analytics for research
struct LWAnalytics {
    
    // MARK: - Private Properties
    
    /// Custom Event that is related to trending data
    private var itemName: CustomEvent
    
    /// Custom Event parameters
    private var properties = [String: String]()
    
    init(itemName: CustomEvent, properties: [String: String]? = nil) {
        self.itemName = itemName
        logEventWithParameters()
    }
    
    private func logEventWithParameters() {
        var parameters = [
            AnalyticsParameterItemID: "id-\(itemName.hashValue)",
            AnalyticsParameterItemName: itemName.rawValue,
            AnalyticsParameterContentType: "cont"]
        
        properties.forEach { key, value in
            parameters[key] = value
        }
        
        Analytics.logEvent(itemName.rawValue, parameters: parameters)
    }
    
}

