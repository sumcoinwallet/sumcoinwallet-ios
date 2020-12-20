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
        VStack {
            //AnimatedCard()
            
            TextField(S.Receive.emailButton, text: $viewModel.emailString)
                .padding([.leading, .trailing], 16)
                .padding(.top, 30)
                .foregroundColor(.red)
            
            Divider().padding([.leading, .trailing], 16)
 
            TextField(S.Import.passwordPlaceholder.capitalized, text: $viewModel.passwordString)                    .padding([.leading, .trailing], 16)
                .padding(.top, 30)

            Divider().padding([.leading, .trailing], 16)
 
            
            Spacer()
            Button(action: {
                print("Button action")
            }) {
                Text("Forgot Password")
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 30)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor.liteWalletBlue))

            }
            
            Spacer()
            Button(action: {
                print("Login")
            }) {
                Text("Login")
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 30)
                    .background(Color(UIColor.liteWalletBlue))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)


            }
            .frame(height: 48, alignment: .center)
            .padding([.leading, .trailing], 16)
            
            Button(action: {
                print("Button action")
            }) {
                Text("Register for LitecoinCard")
                    .padding([.top, .bottom], 30)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor.liteWalletBlue))
                    .cornerRadius(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .frame(height: 48, alignment: .center)
                    .padding([.leading, .trailing], 16)
            }
            

            
            Spacer()
            //heigth 48.0
            
            //tr16.0
            
        }.padding([.leading, .trailing], 16)
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

