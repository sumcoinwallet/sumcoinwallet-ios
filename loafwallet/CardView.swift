//
//  CardView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject
    var viewModel: CardViewModel
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CardView_Previews: PreviewProvider {
    
    static let viewModel = CardViewModel()
    static var previews: some View {
        
        Group {
            CardView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
                .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            CardView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
                .previewDisplayName(DeviceType.Name.iPhone8)
            
            CardView(viewModel: viewModel)
                    .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
                    .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}
