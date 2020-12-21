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
        self.setupTabBar()
    }
 
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(UIColor.liteWalletBlue))
                .frame(height: 60)
            Spacer()
            TabView {
                TransactionsView()
                    .tabItem {
                        Image("history_icon")
                            .renderingMode(.template).colorMultiply(.red)
                        Text(S.History.barItemTitle)
                    }
                Text("Send")
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

//MARK: - Tab bar view appearance
extension MainTabBarView {
    
    func setupTabBar() {
        UITabBar.appearance().barTintColor = UIColor.liteWalletBlue
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    
    static let viewModel = MainTabBarViewModel()
    
    static var previews: some View {
        
        Group {
            MainTabBarView(viewModel: viewModel)
        }
    }
}

