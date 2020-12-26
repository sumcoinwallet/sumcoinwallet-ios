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
    
    @State
    var usernameEmail: String = ""
    
    @State
    var password: String = ""
    
    @State
    var confirmPassword: String = ""
    
    @State
    var firstName: String = ""
    
    @State
    var lastName: String = ""
    
    @State
    var kycSSN: String = ""
    
    @State
    var kycIDString: String = ""
    
    @State
    var idTypeString: String = ""
    
    @State
    var address: String = ""
    
    @State
    var city: String = ""
    
    @State
    var state: String = ""
    
    @State
    var country: String = ""
    
    @State
    var zipCodePostCode: String = ""
    
    @State
    var mobileNumber: String = ""
    
    var newUser: [String: Any]
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        newUser = [:]
    }
    
    var body: some View {
        VStack {
            Text(S.Registration.registerCardPhrase)
                .padding(.all, 10)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(UIColor.liteWalletBlue))
                .font(Font(UIFont.barlowBold(size:20.0)))
            
            Form {
                
                Section(header: Text("Customer")) {
                    HStack {
                        VStack {TextField(S.Registration.firstName, text: $firstName)
                            .padding([.leading, .trailing], 5)
                            Divider()
                                .padding([.leading, .trailing], 5)
                            Spacer()

                        }
                        VStack {
                            TextField(S.Registration.lastName, text: $lastName)
                                .padding([.leading, .trailing], 5)
                            Divider()
                                .padding([.leading, .trailing], 5)
                            Spacer()

                        }
                    }
                }
                
                Section(header: Text("Identification")) {
                    VStack {
                        TextField(S.Registration.usernameEmail, text: $usernameEmail).padding([.leading, .trailing], 5)
                        Divider()
                            .padding([.leading, .trailing], 5)
                        Spacer()
                        HStack {
                            VStack {
                                TextField(S.Registration.password,
                                          text: $password)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                            
                            VStack {
                                TextField(S.Registration.confirmPassword,
                                          text: $confirmPassword)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                        }
                        
                        HStack {
                            VStack {
                                TextField(S.Registration.kycSSN,
                                          text: $kycSSN)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                            VStack {
                                TextField(S.Registration.kycIDNumber,
                                          text: $kycIDString)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                        }
                         
                        VStack {
                            TextField(S.Registration.kycIDNumber,
                                      text: $kycIDString)
                                .padding([.leading, .trailing], 5)
                            Divider()
                                .padding([.leading, .trailing], 5)
                            Spacer()
                        }
                    }
                }
                
                Section(header: Text("Location")) {
                    VStack {
                        HStack {
                            VStack {
                                TextField(S.Registration.address, text: $address)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                            }
                            Spacer()
                        }
                        HStack {
                            VStack {
                                TextField(S.Registration.city, text: $city)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                            VStack {
                                TextField(S.Registration.stateProvince, text: $state)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                            
                        }
                        HStack {
                            
                            VStack {
                                TextField(S.Registration.country, text: $country)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                            VStack {
                                TextField(S.Registration.zipPostCode, text: $zipCodePostCode)
                                    .padding([.leading, .trailing], 5)
                                Divider()
                                    .padding([.leading, .trailing], 5)
                                Spacer()
                            }
                        }
                    }
                }
                
                
            }
            
            // Button to register user
            Button(action: {
                viewModel.register(user: self.newUser)
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
            
            Spacer()
        }
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    
    static let viewModel = RegistrationViewModel()
    
    static var previews: some View {
        
        Group {
            RegistrationView(viewModel: viewModel)                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
                .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            RegistrationView(viewModel: viewModel)                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
                .previewDisplayName(DeviceType.Name.iPhone8)
            
            RegistrationView(viewModel: viewModel)                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
                .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}





