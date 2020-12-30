//
//  CardViewController.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/22/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation

import UIKit
import SwiftUI
 

/// A container for a CardView - SwiftUI
class CardViewController: UIViewController {
    
    var viewModel = CardViewModel()
    
    var cardLoggedInView: CardLoggedInView?
    
    var cardView: CardView?
 
    var parentFrame: CGRect?
    
    var swiftUIContainerView = UIHostingController(rootView: AnyView(EmptyView()))
    
    var notificationToken: NSObjectProtocol?
    
    private func updateFromViewModel() {
        
        swiftUIContainerView.remove()
        
        if viewModel.isLoggedIn {
            cardLoggedInView = CardLoggedInView(viewModel: viewModel)
            swiftUIContainerView = UIHostingController(rootView: AnyView(cardLoggedInView))
        } else {
            cardView = CardView(viewModel: viewModel)
            swiftUIContainerView = UIHostingController(rootView: AnyView(cardView))
        }
         
        //Constraint the view to Tab container
        if let size = parentFrame?.size {
            self.swiftUIContainerView.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
        
        addChildViewController(self.swiftUIContainerView)
        self.view.addSubview(self.swiftUIContainerView.view)
        self.swiftUIContainerView.didMove(toParent: self)
        
       
    }
         
     override func viewDidLoad() {
         
        self.updateFromViewModel()
 
        notificationToken = NotificationCenter.default
            .addObserver(forName: NSNotification.Name.LitecoinCardLoginNotification,
                         object: nil,
                         queue: nil) { _ in
                self.updateFromViewModel()
            }
         
        notificationToken = NotificationCenter.default
            .addObserver(forName: NSNotification.Name.LitecoinCardLogoutNotification,
                         object: nil,
                         queue: nil) { _ in
                self.updateFromViewModel()
            }
    }
     
}
    
   
