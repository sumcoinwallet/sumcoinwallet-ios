//
//  RegistrationAlertView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/29/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct RegistrationAlertView<Presenting>: View where Presenting: View {
    
    @Binding
    var shouldStartRegistering: Bool
    
    @Binding
    var didRegister: Bool
    
    let presenting: Presenting
    
    var mainMessage: String
    
    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            HStack{ Spacer()
                ZStack {
                    self.presenting
                        .disabled(shouldStartRegistering)
                    VStack {
                        Text(self.mainMessage)
                            .padding()
                            .font(Font(UIFont.customMedium(size: 16.0)))
                            .foregroundColor(Color(UIColor.liteWalletBlue))
                        ActivityIndicator(isAnimating: $shouldStartRegistering,
                                          style: .medium)
                            .padding(.bottom, 15)
                        Divider()
                        HStack {
                            Button(action: {
                                
                                withAnimation {
                                    self.shouldStartRegistering.toggle()
                                }
                            }) {
                                Text(S.Prompts.dismiss.localizedCapitalized)
                                    .font(Font(UIFont.barlowLight(size: 14.0)))
                                    .foregroundColor(.gray)
                            }.padding([.top,.bottom], 5)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
                    .background(Color.white)
                    .cornerRadius(8)
                    .frame(
                        width: deviceSize.size.width*0.8,
                        height: deviceSize.size.height*0.5
                    )
                    .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
                    .opacity(self.shouldStartRegistering ? 1 : 0)
                }
                Spacer()
            }
        }
    }
}
struct RegistrationAlertView_Previews: PreviewProvider {
    
        static var previews: some View {
            VStack {
                Spacer()
                Text("").padding(.all, 10)
                    .registeredAlertView(shouldStartRegistering: .constant(true),
                                         didRegister: .constant(false),
                                         data: [:],
                                         message: "Registering...")
                Spacer()
            }
        }
}
 
