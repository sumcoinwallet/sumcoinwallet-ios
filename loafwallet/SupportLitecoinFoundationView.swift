//
//  SupportSumcoinWalletView.swift
//  loafwallet
//
//  Created by Kerry Washington on 11/9/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import SwiftUI
import Foundation
import WebKit

/// This cell is under the amount view and above the Memo view in the Send VC
struct SupportSumcoinWalletView: View {

    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: SupportSumcoinWalletViewModel
    
    @State
    private var showSupportLFPage: Bool = false
    
    //MARK: - Public
    var supportSafariView = SupportSafariView(url: FoundationSupport.url,
                                              viewModel: SupportSafariViewModel())
    
    init(viewModel: SupportSumcoinWalletViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
         VStack {
            Spacer(minLength: 40)

            supportSafariView
                .frame(height: 300,
                       alignment: .center)
                .padding([.bottom, .top], 10)
            
            // Copy the LF Address and paste into the SendViewController
            Button(action: {
                UIPasteboard.general.string = FoundationSupport.supportSUMAddress
                self.viewModel.didTapToDismiss?()
            }) {
                Text(S.URLHandling.copy.uppercased())
                    .font(Font(UIFont.customMedium(size: 16.0)))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.white))
                    .background(Color(UIColor.sumcoinWalletBlue))
                    .cornerRadius(4.0)
            }
            .padding([.leading, .trailing], 40)
            .padding(.bottom, 10)

            // Cancel
            Button(action: {
                self.viewModel.didTapToDismiss?()
            }) {
                Text(S.Button.cancel.uppercased())
                    .font(Font(UIFont.customMedium(size: 16.0)))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.sumcoinWalletBlue))
                    .background(Color(UIColor.white))
                    .cornerRadius(4.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.secondaryBorder))
                    )
            }
            .padding([.leading, .trailing], 40)
            
            Spacer(minLength: 100)
        }
    }
}

struct SupportSumcoinWalletView_Previews: PreviewProvider {
    
    static let viewModel = SupportSumcoinWalletViewModel()
    
    static var previews: some View {
        Group {
            SupportSumcoinWalletView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
            
            SupportSumcoinWalletView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
        }
    }
}
