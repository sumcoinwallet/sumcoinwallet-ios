//
//  ForgotView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/24/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct ForgotView: View {
    
    @ObservedObject
    var viewModel: ForgotViewModel
    
    init(viewModel: ForgotViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ForgotView_Previews: PreviewProvider {
    
    static let viewModel = ForgotViewModel()
    static var previews: some View {
        ForgotView(viewModel: viewModel)
    }
}
