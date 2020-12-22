//
//  MainTabBarView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/20/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//
import UIKit
import SwiftUI

struct MainTabBarView: View {
    
    @ObservedObject
    var viewModel: MainTabBarViewModel

    init(viewModel:MainTabBarViewModel) {
        
        self.viewModel = viewModel
        
        //Setup the old UIKit appearance
        UITabBar.appearance().backgroundColor = .liteWalletBlue
        UITabBar.appearance().barStyle = .default
        UITabBar.appearance().barTintColor = .liteWalletBlue
    }
    
    var body: some View {
        
                NavigationView {
                    TabView {
                        Text("History")
                            .tabItem {
                                Image("history_icon")
                                    .renderingMode(.template).colorMultiply(.red)
                                Text(S.History.barItemTitle)
                            }
                        Rectangle()
                            .foregroundColor(.red)
                            .tabItem {
                                Image("send_icon")
                                    .renderingMode(.template).colorMultiply(.blue)
                                Text(S.Send.barItemTitle)
                            }
                        Text("Card")
                            .tabItem {
                                Image("card_icon")
                                    .renderingMode(.template).colorMultiply(.red)
                                Text(S.LitecoinCard.barItemTitle)
                            }
                        Text("Receive")
                            .tabItem {
                                Image("receive_icon")
                                    .renderingMode(.template).colorMultiply(.green)
                                Text(S.Receive.barItemTitle)
                            }
                        Text("Buy")
                            .tabItem {
                                Image("litecoin_cutout24")
                                    .renderingMode(.template).colorMultiply(.white)
                                Text(S.BuyCenter.barItemTitle)
                            }
                    }
                    .accentColor(.white)

                }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    
    static let viewModel = MainTabBarViewModel()
    
    static var previews: some View {
        
        Group {
            MainTabBarView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE))
                .previewDisplayName(DeviceType.Name.iPhoneSE)
            MainTabBarView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
                .previewDisplayName(DeviceType.Name.iPhoneSE2)
            MainTabBarView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone7))
                .previewDisplayName(DeviceType.Name.iPhone7)
            MainTabBarView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
                .previewDisplayName(DeviceType.Name.iPhone8)
            MainTabBarView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8Plus))
                .previewDisplayName(DeviceType.Name.iPhone8Plus)
            MainTabBarView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
                .previewDisplayName(DeviceType.Name.iPhone12ProMax)
            
        }
    }
}

