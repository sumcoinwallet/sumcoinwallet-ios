//
//  SettingsRowWithDetails.swift
//  loafwallet
//
//  Created by Kerry Washington on 10/18/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

/// Row with details for Settings View List
struct SettingsRowWithDetails: View {
    
    private let headerText: String
    
    private let infoText: String
    
    
    init(headerText:String, infoText: String) {
        self.headerText = headerText
        self.infoText = infoText
    }
    
    var body: some View {
        HStack {
            Text(headerText)
                .font(Font(UIFont.barlowRegular(size: 14)))
                .padding(.leading, 20)
            Spacer()
            Text(infoText)
                .font(Font(UIFont.barlowLight(size: 13)))
                .padding(.trailing, 10)
        }
    }
}

struct SettingsRowWithDetails_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowWithDetails(headerText: "Header", infoText: "Info")
    }
}
