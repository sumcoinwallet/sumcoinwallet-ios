//
//  RegistrationView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/24/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject
    var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    
    static let viewModel = RegistrationViewModel()
    
    static var previews: some View {
        RegistrationView(viewModel: viewModel)
    }
}
