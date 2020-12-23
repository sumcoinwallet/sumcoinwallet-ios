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
    
    var parentFrame: CGRect?
    
    override func viewWillAppear(_ animated: Bool) {
        
        let viewModel = CardViewModel()
        let swiftUIContainerView = UIHostingController(rootView: CardView(viewModel: viewModel))
        
        //Constraint the view to Tab container 
        if let size = parentFrame?.size {
            swiftUIContainerView.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
 
        addChildViewController(swiftUIContainerView)
        self.view.addSubview(swiftUIContainerView.view)
        swiftUIContainerView.didMove(toParent: self)
    }
         
    override func viewDidLoad() { }
     
}
    
   
