//
//  UINavigationController+BRAdditions.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2016-11-29.
//  Copyright © 2016 breadwallet LLC. All rights reserved.
//

import UIKit
import SwiftUI

extension UINavigationController {
    
    func setDefaultStyle() {
        setClearNavbar()
        setBlackBackArrow()
    }
    
    func setWhiteStyle() {
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.customBold(size: 17.0)
        ]
        setTintableBackArrow()
    }
    
    func setClearNavbar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    func setNormalNavbar() {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
    }
    
    func setBlackBackArrow() {
        let image = #imageLiteral(resourceName: "Back")
        let renderedImage = image.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = renderedImage
        navigationBar.backIndicatorTransitionMaskImage = renderedImage
    }
    
    func setTintableBackArrow() {
        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "Back")
        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Back")
    }
    
    //https://stackoverflow.com/questions/56651245/how-to-change-the-status-bar-background-color-and-text-color-on-ios-13
    //DEV: nice looking solution
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}

//struct NavigationConfigurator: UIViewControllerRepresentable {
//    var configure: (UINavigationController) -> Void = { nc in
//
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
//        UIViewController()
//    }
//    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
//        if let nc = uiViewController.navigationController {
//            self.configure(nc)
//        }
//    }
//
//}

