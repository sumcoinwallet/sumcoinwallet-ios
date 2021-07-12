//
//  Functions.swift
//  breadwallet
//
//  Created by Adrian Corscadden on 2017-06-18.
//  Copyright © 2021 Sumcoin Wallet All rights reserved.
//

import UIKit

func guardProtected(queue: DispatchQueue, callback: @escaping () -> Void) {
    
    DispatchQueue.main.async(execute: {
        if UIApplication.shared.isProtectedDataAvailable {
            callback()
        } else {
            var observer: Any?
            observer = NotificationCenter.default.addObserver(forName: .UIApplicationProtectedDataDidBecomeAvailable, object: nil, queue: nil,
                                                              using: { note in
                                                                queue.async {
                                                                    callback()
                                                                }
            if let observer = observer {
                NotificationCenter.default.removeObserver(observer)
            }
            })
        }
    })
}

func strongify<Context: AnyObject>(_ context: Context, closure: @escaping(Context) -> Void) -> () -> Void {
    return { [weak context] in
        guard let strongContext = context else { return }
        closure(strongContext)
    }
}

func strongify<Context: AnyObject, Arguments>(_ context: Context?, closure: @escaping (Context, Arguments) -> Void) -> (Arguments) -> Void {
    return { [weak context] arguments in
        guard let strongContext = context else { return }
        closure(strongContext, arguments)
    }
}
