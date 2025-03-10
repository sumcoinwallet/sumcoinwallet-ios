//
//  CardView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/23/20.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.
//

import SwiftUI
import UIKit


struct CardView: View {
      
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: CardViewModel
    
    @ObservedObject
    var registrationModel = RegistrationViewModel()
    
    @ObservedObject
    var loginModel = LoginViewModel()
    
    @ObservedObject
    var animatedViewModel = AnimatedCardViewModel()
    
    @State
    private var shouldShowLoginModal: Bool = false
    
    @State
    private var didFailToLogin: Bool = false
    
    @State
    var didTapIForgot: Bool = false
    
    @State
    var didShowCardView: Bool = false
    
    @State
    private var shouldShowRegistrationView: Bool = false
    
    @State
    private var shouldShowPassword: Bool = false
    
    @State
    private var forgotEmailAddressInput = ""
    
    @State
    var didCompleteLogin: Bool = false
    
    @State
    var isEmailValid: Bool = false
    
    init(viewModel: CardViewModel) {
         
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                //MARK: - Animated Card View
                Group {
                    AnimatedCardView(viewModel: animatedViewModel, isLoggedIn: $didCompleteLogin)
                        .frame(minWidth:0,
                               maxWidth:
                                didCompleteLogin ? geometry.size.width * 0.4 :
                                geometry.size.width * 0.6)
                        .padding(.all, didCompleteLogin ? 20 : 30)
                }
                
                //MARK: - Login Textfields
                Group {
                    
                    TextField(S.Receive.emailButton,
                              text: $loginModel.emailString)
                        .onReceive(loginModel.$emailString) { currentEmail in
                            if currentEmail.count < 4 ||  !registrationModel.isEmailValid(emailString: currentEmail) {
                                isEmailValid = false
                            } else {
                                isEmailValid = true
                            }
                    }
                    .foregroundColor(isEmailValid ? .black : Color(UIColor.sumcoinOrange))
                    .font(Font(UIFont.barlowSemiBold(size:18.0)))
                    .accentColor(Color(UIColor.sumcoinWalletBlue))
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 30)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    
                    Divider().padding([.leading, .trailing], 20)
                    
                    HStack {
                        if shouldShowPassword {
                            
                            TextField(S.Import.passwordPlaceholder.capitalized, text: $loginModel.passwordString)
                                .foregroundColor(.black)
                                .font(Font(UIFont.barlowSemiBold(size:18.0)))
                                .accentColor(Color(UIColor.sumcoinWalletBlue))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .autocapitalization(.none)
                                .keyboardType(.asciiCapable)
                            
                        } else {
                            
                            SecureField(S.Import.passwordPlaceholder.capitalized, text: $loginModel.passwordString)
                                .foregroundColor(.black)
                                .font(Font(UIFont.barlowSemiBold(size:18.0)))
                                .accentColor(Color(UIColor.sumcoinWalletBlue))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .autocapitalization(.none)
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
                
                //MARK: - Action Buttons
                Group {
                    
                    // Forgot password button
                    Button(action: {
                        didTapIForgot = true
                    }) {
                        
                        Text(S.SumcoinCard.forgotPassword)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .font(Font(UIFont.barlowLight(size: 15)))
                            .foregroundColor(Color(UIColor.sumcoinWalletBlue))
                            .padding(.all, 30)
                    }
                    
                    Spacer(minLength: 5)
                    
                    // Login button
                    Button(action: {
                        shouldShowLoginModal = true
                         loginModel.login { didLogin in
                            
                            if didLogin {
                                viewModel.isLoggedIn = true
                                shouldShowLoginModal = false
                                 NotificationCenter.default.post(name: .SumcoinCardLoginNotification, object: nil,
                                                                userInfo: nil)
                            } else {
                                viewModel.isLoggedIn = true
                                didFailToLogin = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                    shouldShowLoginModal = false
                                } 
                            }
                        }
                        
                    }) {
                        
                        Text(S.SumcoinCard.login)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .padding()
                            .font(Font(UIFont.barlowMedium(size: 16.0)))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(.white)
                            .background(Color(UIColor.sumcoinWalletBlue))
                            .cornerRadius(4.0)
                            .overlay(
                                RoundedRectangle(cornerRadius:4)
                                    .stroke(Color(UIColor.sumcoinWalletBlue), lineWidth: 1)
                            )
                    }
                    .padding([.leading, .trailing], 16)
                    
                    // Registration button
                    Button(action: {
                        shouldShowRegistrationView = true
                    }) {
                        Text(S.SumcoinCard.registerCard)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .padding()
                            .font(Font(UIFont.barlowMedium(size: 15.0)))
                            .foregroundColor(Color(UIColor.sumcoinWalletBlue))
                            .overlay(
                                RoundedRectangle(cornerRadius:4)
                                    .stroke(Color(UIColor.sumcoinWalletBlue), lineWidth: 1)
                            )
                            .padding([.leading, .trailing], 16)
                            .padding([.top,.bottom], 15)
                    }
                    .sheet(isPresented: $shouldShowRegistrationView) {
                        RegistrationView(viewModel: registrationModel)
                    }
                }
                Spacer()
            }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.UIKeyboardWillShow)) { _ in
            animatedViewModel.dropOffset = -200
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.UIKeyboardWillHide)) { _ in
            animatedViewModel.dropOffset = 0
        }.onAppear(){
            didShowCardView = true
        }
        .cardV1ToastView(isShowingCardToast: $didShowCardView)
        .animation(.easeOut)
        .transition(.scale)       
        .forgotPasswordView(isShowingForgot: $didTapIForgot,
                            emailString: $forgotEmailAddressInput,
                            message: S.SumcoinCard.forgotPassword)
        .loginAlertView(isShowingLoginAlert: $shouldShowLoginModal,
                        didFail: $didFailToLogin,
                        message: S.SumcoinCard.login)
        .registeredAlertView(shouldStartRegistering: $registrationModel.isRegistering,
                             didRegister: $registrationModel.didRegister,
                             data: registrationModel.dataDictionary,
                             message: $registrationModel.message)
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



