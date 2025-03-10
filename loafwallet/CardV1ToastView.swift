//
//  CardV1ToastView.swift
//  loafwallet
//
//  Created by Kerry Washington on 3/2/21.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.

import SwiftUI

struct CardV1ToastView<Presenting>: View where Presenting: View {
    
    @Binding
    var isShowingCardToast: Bool
    
    let presenting: Presenting 
    
    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            HStack{
                ZStack {
                    self.presenting.disabled(isShowingCardToast)
                    VStack {
                        Text(S.SumcoinCard.Disclaimer.title)
                            .font(Font(UIFont.barlowBold(size: 22.0)))
                            .foregroundColor(Color.white)
                            .padding([.top,.bottom], 20)
                        Text(S.SumcoinCard.Disclaimer.description)
                            .font(Font(UIFont.barlowMedium(size: 18.0)))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .padding(.all, 10)
                        Text(S.SumcoinCard.Disclaimer.bullets)
                            .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                            .foregroundColor(Color.white)
                            .padding(.all, 10)
                        Text(S.SumcoinCard.Disclaimer.referral)
                            .font(Font(UIFont.barlowMedium(size: 18.0)))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 20)
                            .padding([.leading,.trailing], 40)
                        
                        Divider().background(Color.white)
                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.isShowingCardToast.toggle()
                                }
                            }) {
                                Text(S.Button.ok)
                                    .frame(minWidth:0, maxWidth: .infinity)
                                    .padding()
                                    .font(Font(UIFont.barlowBold(size: 20.0)))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
                    .background(Color(UIColor.sumcoinWalletBlue))
                    .cornerRadius(8)
                    .shadow(color: .black, radius: 10, x: 5, y: 5)
                    .opacity(self.isShowingCardToast ? 1 : 0)
                }
            }
        }
    }
}

struct CardV1ToastView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        VStack {
            Spacer()
            Text("")
                .padding(.all, 10)
                .cardV1ToastView(isShowingCardToast: .constant(true))
            Spacer()
        }
    }
}


