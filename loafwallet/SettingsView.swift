//
//  SettingsView.swift
//  loafwallet
//
//  Created by Kerry Washington on 10/17/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI



struct SettingsView: View {
    
    private func environmentType() -> String {
        var envName = "Release"
        #if Debug || Testflight
        envName = "Debug"
        #endif
        return envName
    }
      
    var body: some View {
        
        List() {
            Spacer()

            Section() {
                Text("About")
                HStack {
                    Text(S.Settings.litewalletVersion)
                    Spacer()
                    Text(AppVersion.string)
                }
                HStack {
                    Text("Twitter")
                    Spacer()
                    Text("@Litewallet_App")
                }
                HStack {
                    Text("Facebook")
                    Spacer()
                    Text("litewallet.app.56")
                }
                HStack {
                    Text(S.Settings.litewalletEnvironment)
                    Spacer()
                    Text(environmentType())
                }
            }
//            Section("Wallet") {
//
//                Text("eer")
//
//            }
            
//            Section("Settings") {
//
//                Button(action: {
//
//                }) {
//                    VStack {
//                        HStack {
//                            Text(S.MenuButton.lock)
//                                .font(Font(UIFont.barlowSemiBold(size: 14)))
//                                .fontWeight(.semibold)
//                            Spacer()
//                            Image("Lock")
//                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .padding(.trailing, 10)
//                        }
//                    }
//                }
//
//                Text(S.Settings.languages)
//
//                HStack{
//                    Text(S.Settings.currency)
//                    Spacer()
//                    Text("USD")
//                }
//            }
            
//            Section("Support") {
//
//                Button(action: {
//
//                }) {
//                    VStack {
//                        HStack {
//                            Text(S.MenuButton.support)
//                                .font(Font(UIFont.barlowSemiBold(size: 14)))
//                                .fontWeight(.semibold)
//                            Spacer()
//                            Image("FaqFill")
//                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .padding(.trailing, 10)
//                        }
//                    }
//                }
//
//                Button(action: {
//
//                }) {
//                    VStack {
//                        HStack {
//                            Text(S.Settings.shareData)
//                                .font(Font(UIFont.barlowSemiBold(size: 14)))
//                                .fontWeight(.semibold)
//                            Spacer()
//                        }
//                    }
//                }
//            }
//
//            Section("Blockchain") {
//
//                Text("eer")
//            }
             
//            Section {
//                Button(action: {
//
//                }) {
//                    VStack{
//                        HStack {
//                            Text(S.MenuButton.security)
//                                .font(Font(UIFont.barlowSemiBold(size: 14)))
//                                .fontWeight(.semibold)
//                            Spacer()
//                            Image("Shield")
//                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .padding(.trailing, 10)
//                        }
//                    }
//                }
//
//                Text("About")
//                HStack {
//                    Spacer()
//                    Text(S.About.footer)
//                        .font(Font(UIFont.barlowLight(size: 12)))
//                        .fontWeight(.light)
//                        .multilineTextAlignment(.center)
//                    Spacer()
//                }
//            }
        
        }
        .listStyle(PlainListStyle())
        .background(Color(.litecoinWhite))
    }
}
 
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


