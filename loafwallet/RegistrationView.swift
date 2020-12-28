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
    
    @Environment(\.presentationMode)
    var presentationMode

    
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
    var isPassport: Bool = true
    
    @State
    var address: String = ""
    
    @State
    var city: String = ""
    
    @State
    var state: String = ""
    
    @State
    var country: String = "US"
    
    @State
    var zipCodePostCode: String = ""
    
    @State
    var mobileNumber: String = ""
    
    @State
    var currentOffset = 0.0
    
    @State
    private var shouldStartRegistering: Bool = false
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = .clear
    }
    
    //DEV: This layout needs to be polished after v1 so it looks nicer.
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                Text(S.Registration.registerCardPhrase)
                    .padding(.all, 20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(Font(UIFont.barlowBold(size:20.0)))
                
                Form {
                    Section() {
                        VStack {
                            
                            //MARK: - User names
                            Group {
                                HStack {
                                    VStack {
                                        TextField(S.Registration.firstName,
                                                  text: $firstName)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .keyboardType(.namePhonePad)
                                            .padding([.leading, .trailing], 8)
                                            .padding(.top, 12)
                                            .foregroundColor(viewModel.isDataValid(dataType: .genericString,
                                                                                   data: firstName) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        TextField(S.Registration.lastName,
                                                  text: $lastName)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .keyboardType(.namePhonePad)
                                            .padding([.leading, .trailing], 8)
                                            .padding(.top, 12)
                                            .foregroundColor(viewModel.isDataValid(dataType: .genericString,
                                                                                   data: lastName) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                }
                            }
                            
                            //MARK: - Login credentials
                            Group {
                                   TextField(S.Receive.emailButton,
                                          text: $usernameEmail)
                                    .font(Font(UIFont.barlowBold(size: 16.0)))
                                    .keyboardType(.emailAddress)
                                    .padding([.leading, .trailing], 8)
                                    .foregroundColor(viewModel.isDataValid(dataType: .email,
                                                                           data: usernameEmail) ? .black : Color(UIColor.litecoinOrange))
                                Divider()
                                    .padding([.leading, .bottom, .trailing], 8)
                                    .padding(.top, 1)
                                Spacer()
                                
                                HStack {
                                    VStack {
                                        TextField(S.Registration.password,
                                                  text: $password)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .autocapitalization(.none)
                                            .keyboardType(.default)
                                            .padding([.leading, .trailing], 8)
                                            .foregroundColor(viewModel.isDataValid(dataType: .password,
                                                                                   data: password) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        TextField(S.Registration.confirmPassword,
                                                  text: $confirmPassword)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .autocapitalization(.none)
                                            .keyboardType(.default)
                                            .padding([.leading, .trailing], 8)
                                            .foregroundColor(viewModel.isDataValid(dataType: .confirmation,
                                                                                   firstString: password,
                                                                                   data: confirmPassword) ? .black : Color(UIColor.litecoinOrange))
                                         Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                            //MARK: - Mobile number
                            Group {
                                VStack {
                                    TextField(S.Registration.mobileNumber, text: $mobileNumber)
                                        .font(Font(UIFont.barlowBold(size: 16.0)))
                                        .keyboardType(.numberPad)
                                        .padding([.leading, .trailing], 8)
                                        .foregroundColor(viewModel.isDataValid(dataType: .mobileNumber,
                                                                               data: mobileNumber) ? .black : Color(UIColor.litecoinOrange))
                                    Divider()
                                        .padding([.leading, .bottom, .trailing], 8)
                                        .padding(.top, 1)
                                    
                                }
                            }
                            
                            //MARK: - Location 
                            Group {
                                HStack {
                                    VStack {
                                        TextField(S.Registration.address, text: $address)
                                            .padding([.leading, .trailing], 8)
                                            .padding(.top, 12)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .foregroundColor(viewModel.isDataValid(dataType: .genericString,
                                                                                   data: address) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    VStack {
                                        TextField(S.Registration.city, text: $city)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .padding([.leading, .trailing], 8)
                                            .foregroundColor(viewModel.isDataValid(dataType: .genericString,
                                                                                   data: city) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                    VStack {
                                        TextField(S.Registration.stateProvince, text: $state)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .padding([.leading, .trailing], 8)
                                            .foregroundColor(viewModel.isDataValid(dataType: .genericString,
                                                                                   data: state) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                }
                                
                                HStack { 
                                    VStack {
                                        //DEV: Will change when EU support comes
                                        TextField("US", text: $country)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .foregroundColor(.gray)
                                            .padding(.leading, 8)
                                            .padding(.trailing, 5)
                                            .disabled(true)
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                        Spacer()
                                    }
                                    VStack {
                                        TextField(S.Registration.zipPostCode, text: $zipCodePostCode)
                                            .font(Font(UIFont.barlowBold(size: 16.0)))
                                            .padding([.leading, .trailing], 8)
                                            .foregroundColor(viewModel.isDataValid(dataType: .genericString,
                                                                                   data: zipCodePostCode) ? .black : Color(UIColor.litecoinOrange))
                                        Divider()
                                            .padding([.leading, .bottom, .trailing], 8)
                                            .padding(.top, 1)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding([.leading,.top,.trailing], 5)
                    
                }
                .padding(.bottom,CGFloat(self.currentOffset))
                
                HStack(spacing: 4) {
                    
                    //MARK: - Action Buttons
                    
                    // Button to reset fields
                    Button(action: {
                        resetFields()
                    }) {
                        Text(S.Button.resetFields)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .padding()
                            .font(Font(UIFont.barlowRegular(size:20.0)))
                            .foregroundColor(Color(UIColor.litecoinOrange))
                            .overlay(
                                RoundedRectangle(cornerRadius:4)
                                    .stroke(Color(UIColor.white), lineWidth: 1)
                            )
                            .padding(.leading, 16)
                            .padding([.bottom], 30)
                    }.foregroundColor(.red)
                    
                    Spacer()
                    
                    // Button to register user
                    Button(action: {
                        viewModel.verify(data: loadDataDictionary()) { (isAllRegisterDataValid) in
                            
                            //Pass state to trigger the modal view
                            shouldStartRegistering = isAllRegisterDataValid
                            
                            //Make a registration call
                            viewModel.register()
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text(S.Button.submit)
                            .frame(minWidth:0, maxWidth: .infinity)
                            .padding()
                            .font(Font(UIFont.barlowBold(size:20.0)))
                            .foregroundColor(Color(UIColor.liteWalletBlue))
                            .background(Color.white)
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius:4)
                                    .stroke(Color(UIColor.white), lineWidth: 1)
                            )

                            .padding(.trailing, 16)
                            .padding([.bottom], 30)
                    }.padding(.bottom,CGFloat(-self.currentOffset))
                    
                }
            }.background(Color(UIColor.liteWalletBlue))
            .edgesIgnoringSafeArea(.all)
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.UIKeyboardWillShow)) { notification in
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.currentOffset = Double(keyboardSize.height)
            }
            
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.UIKeyboardWillHide)) { notification in
            self.currentOffset = 0.0
        }
        
    }
    
    private func resetFields() {
        usernameEmail = ""
        password = ""
        confirmPassword  = ""
        firstName = ""
        lastName  = ""
        kycSSN = ""
        kycIDString = ""
        idTypeString = ""
        address = ""
        city = ""
        state = ""
        zipCodePostCode = ""
        mobileNumber = ""
    }
    
    private func loadDataDictionary() -> [String: Any] {
        
        viewModel.dataDictionary["firstName"] = firstName
        viewModel.dataDictionary["lastName"] = lastName
        viewModel.dataDictionary["usernameEmail"] = usernameEmail
        viewModel.dataDictionary["password"] = password
        viewModel.dataDictionary["confirmPassword"] = confirmPassword
        viewModel.dataDictionary["ssn"] = kycSSN
        viewModel.dataDictionary["idType"] = idTypeString
        viewModel.dataDictionary["kycIDString"] = kycIDString
        viewModel.dataDictionary["mobileNumber"] = mobileNumber
        viewModel.dataDictionary["city"] = city
        viewModel.dataDictionary["country"] = country
        viewModel.dataDictionary["state"] = state
        viewModel.dataDictionary["address"] = address
        viewModel.dataDictionary["postCode"] = zipCodePostCode
        return viewModel.dataDictionary
    }
    
}


struct RegistrationView_Previews: PreviewProvider {
    
    static let viewModel = RegistrationViewModel()
    
    static var previews: some View {
        
        Group {
            RegistrationView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
                .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            RegistrationView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
                .previewDisplayName(DeviceType.Name.iPhone8)
            
            RegistrationView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
                .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}








