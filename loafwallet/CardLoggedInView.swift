//
//  CardLoggedInView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/26/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct CardLoggedInView: View {
    
    @ObservedObject
    var viewModel: CardViewModel
    
    @ObservedObject
    var animatedViewModel = AnimatedCardViewModel()
    
    @State
    private var didTapLogin: Bool = false
        
    @State
    private var shouldLogout: Bool = false
      
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CardLoggedInView_Previews: PreviewProvider {
    static let viewModel = CardViewModel()
    static var previews: some View {
        CardLoggedInView(viewModel: viewModel)
    }
}
