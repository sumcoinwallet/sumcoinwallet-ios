//
//  SettingsView.swift
//  loafwallet
//
//  Created by Kerry Washington on 10/17/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
    
    /// View that carries all the elements into the Settings for the user
    ///
    /// - Parameters:
    ///   - viewModel: Object that manages the view
    ///   - edgeInsets: Save lines of code for the section row insets
    ///   - environmentType: Save lines of code for the section row insets

    
    // MARK: - Properties

    @ObservedObject
    var viewModel: SettingsViewModel
     
    // MARK: - Private Properties
    
    /// Static edge insets for all  section headers
    private let edgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    /// Environment is set for the view
    private func environmentType() -> String {
        var envName = "Release"
        #if Debug || Testflight
        envName = "Debug"
        #endif
        return envName
    }
     
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
     
    var body: some View {
        
        List {
            Section(header:
                        HStack {
                            SettingsHeader(headerText: "About")
                        }
                        .listRowInsets(edgeInsets)
            ) {
                
                SettingsRowWithDetails(
                    headerText: S.Settings.litewalletVersion,
                    infoText: AppVersion.string
                )
                
                SettingsRowWithDetails(
                    headerText: "Twitter",
                    infoText: "@Litewallet_App"
                )
                
                SettingsRowWithDetails(
                    headerText: "Facebook",
                    infoText: "litewallet.app.56"
                )
                
                SettingsRowWithDetails(
                    headerText: S.Settings.litewalletEnvironment,
                    infoText: environmentType()
                )
            }
            
            Section(header:
                        HStack {
                            SettingsHeader(headerText: "Wallet")
                        }
                        .listRowInsets(edgeInsets)
            ) {
                Button(action: {
                    
                }) {
                    SettingsRowWithImage(
                        detailText: S.Settings.importTitle
                    )
                }
                
                Button(action: {
                    
                }) {
                    SettingsRowWithImage(
                        detailText: S.Settings.wipe
                    )
                }
                
            }
            
            Section(header:
                        HStack {
                            SettingsHeader(headerText: "Settings")
                        }
                        .listRowInsets(edgeInsets)
            ) {
                Button(action: {
                    
                }) {
                    SettingsRowWithImage(
                        detailText: S.MenuButton.lock,
                        imageString: "Lock"
                    )
                }
                
                SettingsRowWithDetails(
                    headerText: S.Settings.languages,
                    infoText: viewModel.preferredLanguage
                )
                
                SettingsRowWithDetails(
                    headerText: S.Settings.currency,
                    infoText: viewModel.displayCurrency
                )
                
            }
            
            Section(header:
                        HStack {
                            SettingsHeader(headerText: "Support")
                        }
                        .listRowInsets(edgeInsets)
            ) {
                Button(action: {
                    
                }) {
                    SettingsRowWithImage(
                        detailText: S.Settings.contactSupport,
                        imageString: "FaqFill"
                    )
                }
                
                Button(action: {
                    
                }) {
                    SettingsRowWithImage(
                        detailText: S.Settings.shareData
                    )
                }
            }
            
            Section(header:
                        HStack {
                            SettingsHeader(headerText: "Blockchain")
                        }
                        .listRowInsets(edgeInsets)
            ) {
                SettingsRowWithDetails(
                    headerText: S.ReScan.alertTitle,
                    infoText: "Chain"
                )
            }
        }
        
    }
}

struct SettingsHeader: View {
    
    private let headerText: String
    
    init(headerText:String) {
        self.headerText = headerText
    }
    
    var body: some View {
        HStack {
            Text(headerText)
                .fontWeight(.semibold)
                .font(Font(UIFont.barlowSemiBold(size: 14)))
                .padding(.leading, 20)
            Spacer()
        }
    }
}





 







