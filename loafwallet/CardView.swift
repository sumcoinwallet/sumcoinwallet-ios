//
//  CardView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI
import UIKit

struct CardView: View {
    
    @ObservedObject
    var viewModel: CardViewModel
    
    @ObservedObject
    var animatedViewModel = AnimatedCardViewModel()
    
    @State
    private var didTapLogin: Bool = false
    
    @State
    var didTapIForgot: Bool = false

    @State
    private var shouldShowRegistrationView: Bool = false
    
    @State
    private var shouldShowPassword: Bool = false
    
    @State
    private var forgotEmailAddressInput = ""
      
    @State
    var didCompleteLogin: Bool = false
    
 
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                // Animated Card View
                Group {
                    AnimatedCardView(viewModel: animatedViewModel, isLoggedIn: $didCompleteLogin)
                        .frame(minWidth:0,
                               maxWidth: didCompleteLogin ? geometry.size.width * 0.4 :  geometry.size.width * 0.6)
                        .padding(.all, didCompleteLogin ? 20 : 30)
                }
                
                // Login Textfields
                Group {
                    
                    TextField(S.Receive.emailButton, text: $viewModel.emailString)
                        .font(Font(UIFont.customBody(size:22.0)))
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 30)
                        .foregroundColor(.black)
                        .keyboardType(.emailAddress)
                    
                    Divider().padding([.leading, .trailing], 20)
                    
                    HStack {
                        if shouldShowPassword {
                            TextField(S.Import.passwordPlaceholder.capitalized, text: $viewModel.passwordString)
                                .font(Font(UIFont.customBody(size:22.0)))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .keyboardType(.asciiCapable)
                        } else { 
                            SecureField(S.Import.passwordPlaceholder.capitalized, text: $viewModel.passwordString)
                                .font(Font(UIFont.customBody(size:22.0)))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .keyboardType(.asciiCapable)
                        }
                        Spacer()
                        Button(action: {
                            shouldShowPassword.toggle()
                        }) {
                            Image(systemName: shouldShowPassword ? "eye.fill" : "eye.slash.fill")
                                .padding(.top, 20)
                                .padding(.trailing, 20)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Divider().padding([.leading, .trailing], 20)
                    Spacer()
                }
                
                // Action Buttons
                Group {
                    
                    // Forgot password button
                    Button(action: {
                        didTapIForgot = true
                    }) {
                        
                        Text(S.LitecoinCard.forgotPassword)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .font(Font(UIFont.barlowLight(size: 15)))
                            .foregroundColor(Color(UIColor.liteWalletBlue))
                            .padding(.all, 30)
                    }
                
                    Spacer(minLength: 5)
                    
                    // Login button
                    Button(action: {
                        didTapLogin = true
                        viewModel.login { didLogin in
                            print(didLogin)
                        }
                    }) {
                         
                      Text(S.LitecoinCard.login)
                        .frame(minWidth:0, maxWidth: .infinity)
                        .padding()
                        .font(Font(UIFont.customMedium(size: 16.0)))
                        .padding([.leading, .trailing], 16)
                        .foregroundColor(.white)
                        .background(Color(UIColor.liteWalletBlue))
                        .overlay(
                            RoundedRectangle(cornerRadius:4)
                                .stroke(Color(UIColor.liteWalletBlue), lineWidth: 1)
                        )
                    }
                    .padding([.leading, .trailing], 16)

                    // Registration button
                    Button(action: {
                            shouldShowRegistrationView = true
                        }) {
                            Text(S.LitecoinCard.registerCard)
                                .frame(minWidth:0, maxWidth: .infinity)
                                .padding()
                                .font(Font(UIFont.customMedium(size: 15.0)))
                                .foregroundColor(Color(UIColor.liteWalletBlue))
                                .overlay(
                                    RoundedRectangle(cornerRadius:4)
                                        .stroke(Color(UIColor.liteWalletBlue), lineWidth: 1)
                                )
                                .padding([.leading, .trailing], 16)
                                .padding([.top,.bottom], 15)
                        }
                        .sheet(isPresented: $shouldShowRegistrationView) {
                            RegistrationView(viewModel: RegistrationViewModel())
                        }
                }
                Spacer()
            }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.UIKeyboardWillShow)) { _ in
            animatedViewModel.dropOffset = -200
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.UIKeyboardWillHide)) { _ in
            animatedViewModel.dropOffset = 0
        }
        .forgotPasswordView(isShowingForgot: $didTapIForgot,
                            emailString: $forgotEmailAddressInput,
                            message: S.LitecoinCard.forgotPassword)
        .loginAlertView(isShowingLogin: $didTapLogin,
                        message: S.LitecoinCard.login)
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
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
 
