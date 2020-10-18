//
//  SettingsRowWithImage.swift
//  loafwallet
//
//  Created by Kerry Washington on 10/18/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

/// Row with image for Settings View List
struct SettingsRowWithImage: View {
    
    private let detailText: String
    
    private let imageString: String
    
    init(detailText:String, imageString: String = "") {
        self.detailText = detailText
        self.imageString = imageString
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(detailText)
                    .font(Font(UIFont.barlowRegular(size: 14)))
                    .padding(.leading, 20)
                Spacer()
                Image(imageString)
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct SettingsRowWithImage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowWithImage(detailText: "Detail", imageString: "")
    }
}
