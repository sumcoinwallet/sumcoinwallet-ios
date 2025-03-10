//
//  TabBarViewController.swift
//  loafwallet
//
//  Created by Kerry Washington on 11/17/19.
//  Copyright © 2021 Sumcoin Wallet. All rights reserved.

import UIKit
import Foundation 

class TabBarViewController: UIViewController, Subscriber, Trackable, UITabBarDelegate {
    
    let kInitialChildViewControllerIndex = 0 // TransactionsViewController
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var walletBalanceLabel: UILabel!
	
    var primaryBalanceLabel: UpdatingLabel?
    var secondaryBalanceLabel: UpdatingLabel?
    private let largeFontSize: CGFloat = 24.0
    private let smallFontSize: CGFloat = 12.0
    private var hasInitialized = false
    private var didLoginSumcoinCardAccount = false
    private let dateFormatter = DateFormatter()
    private let equalsLabel = UILabel(font: .barlowMedium(size: 12), color: .whiteTint)
    private var regularConstraints: [NSLayoutConstraint] = []
    private var swappedConstraints: [NSLayoutConstraint] = []
    private let currencyTapView = UIView()
    private let storyboardNames:[String] = ["Transactions","Send","Card","Receive","Buy"]
    var storyboardIDs:[String] = ["TransactionsViewController","SendSUMViewController","CardViewController","ReceiveSUMViewController","BuyTableViewController"]
    var viewControllers:[UIViewController] = []
    var activeController:UIViewController? = nil
    var updateTimer: Timer?
    var store: Store?
    var walletManager: WalletManager?
    var exchangeRate: Rate? {
        didSet { setBalances() }
    }
    
    private var balance: UInt64 = 0 {
        didSet { setBalances() }
    }
    
    var isSumSwapped: Bool? {
        didSet { setBalances() }
    }
    
    @IBAction func showSettingsAction(_ sender: Any) {
        guard let store = self.store else {
            NSLog("ERROR: Store not set")
            return
        }
        store.perform(action: RootModalActions.Present(modal: .menu))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModels()
        setupViews()
        configurePriceLabels()
        addSubscriptions()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
        
        for (index, storyboardID) in self.storyboardIDs.enumerated() {
            let controller = UIStoryboard.init(name: storyboardNames[index], bundle: nil).instantiateViewController(withIdentifier: storyboardID)
            viewControllers.append(controller)
        }
        
        self.updateTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            self.setBalances()
        }
        
        guard let array = self.tabBar.items else {
            NSLog("ERROR: no items found")
            return
        }
        self.tabBar.selectedItem = array[kInitialChildViewControllerIndex]
    }
    
    deinit {
        self.updateTimer = nil
    }
    
    private func setupModels() {
        
        guard let store = self.store else { return }
 
         isSumSwapped = store.state.isSumSwapped
        
        if let rate = store.state.currentRate {
            exchangeRate = rate
            let placeholderAmount = Amount(amount: 0, rate: rate, maxDigits: store.state.maxDigits)
            secondaryBalanceLabel = UpdatingLabel(formatter: placeholderAmount.localFormat)
            primaryBalanceLabel = UpdatingLabel(formatter: placeholderAmount.sumFormat)
        } else {
            secondaryBalanceLabel = UpdatingLabel(formatter: NumberFormatter())
            primaryBalanceLabel = UpdatingLabel(formatter: NumberFormatter())
        } 
    }
    
    private func setupViews() {
        
        walletBalanceLabel.text = S.ManageWallet.balance + ":"

        if #available(iOS 11.0, *),
           let  backgroundColor = UIColor(named: "mainColor") {
            headerView.backgroundColor = backgroundColor
            tabBar.barTintColor = backgroundColor
            containerView.backgroundColor = backgroundColor
            self.view.backgroundColor = backgroundColor
        } else {
            headerView.backgroundColor = .sumcoinWalletBlue
            tabBar.barTintColor = .sumcoinWalletBlue
            containerView.backgroundColor = .sumcoinWalletBlue
            self.view.backgroundColor = .sumcoinWalletBlue
        }
    }
    
    private func configurePriceLabels() {
        
        //TODO: Debug the reizing of label...very important
        guard let primaryLabel = self.primaryBalanceLabel ,
              let secondaryLabel = self.secondaryBalanceLabel else {
            NSLog("ERROR: Price labels not initialized")
            return
        }
        
        let priceLabelArray = [primaryBalanceLabel,secondaryBalanceLabel,equalsLabel]
        
        priceLabelArray.enumerated().forEach { (index, view) in
            view?.backgroundColor = .clear
            view?.textColor = .white
        }
        
        primaryLabel.font = UIFont.barlowSemiBold(size: largeFontSize)
        secondaryLabel.font = UIFont.barlowSemiBold(size: largeFontSize)
        
        equalsLabel.text = "="
        headerView.addSubview(primaryLabel)
        headerView.addSubview(secondaryLabel)
        headerView.addSubview(equalsLabel)
        headerView.addSubview(currencyTapView)
        
        secondaryLabel.constrain([
                                    secondaryLabel.constraint(.firstBaseline, toView: primaryLabel, constant: 0.0) ])
        
        equalsLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        regularConstraints = [
            primaryLabel.firstBaselineAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            primaryLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: C.padding[1]*1.25),
            equalsLabel.firstBaselineAnchor.constraint(equalTo: primaryLabel.firstBaselineAnchor, constant: 0),
            equalsLabel.leadingAnchor.constraint(equalTo: primaryLabel.trailingAnchor, constant: C.padding[1]/2.0),
            secondaryLabel.leadingAnchor.constraint(equalTo: equalsLabel.trailingAnchor, constant: C.padding[1]/2.0),
        ]
        
        swappedConstraints = [
            secondaryLabel.firstBaselineAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            secondaryLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: C.padding[1]*1.25),
            equalsLabel.firstBaselineAnchor.constraint(equalTo: secondaryLabel.firstBaselineAnchor, constant: 0),
            equalsLabel.leadingAnchor.constraint(equalTo: secondaryLabel.trailingAnchor, constant: C.padding[1]/2.0),
            primaryLabel.leadingAnchor.constraint(equalTo: equalsLabel.trailingAnchor, constant: C.padding[1]/2.0),
        ]
        
        if let isSUMSwapped = self.isSumSwapped {
            NSLayoutConstraint.activate(isSUMSwapped ? self.swappedConstraints : self.regularConstraints)
        }
        
        currencyTapView.constrain([
                                    currencyTapView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
                                    currencyTapView.trailingAnchor.constraint(equalTo: self.settingsButton.leadingAnchor, constant: -C.padding[5]),
                                    currencyTapView.topAnchor.constraint(equalTo: primaryLabel.topAnchor, constant: 0),
                                    currencyTapView.bottomAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: C.padding[1]) ])
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(currencySwitchTapped))
        currencyTapView.addGestureRecognizer(gr)
    }
    //MARK: - Adding Subscriptions
    private func addSubscriptions() {
        guard let store = self.store else {
            NSLog("ERROR - Store not passed")
            return
        }
        
        guard let primaryLabel = self.primaryBalanceLabel ,
              let secondaryLabel = self.secondaryBalanceLabel else {
            NSLog("ERROR: Price labels not initialized")
            return
        }
        
        store.subscribe(self, selector: { $0.walletState.syncProgress != $1.walletState.syncProgress },
                        callback: { _ in
                            self.tabBar.selectedItem = self.tabBar.items?.first
                        })
        
        store.lazySubscribe(self,
                            selector: { $0.isSumSwapped != $1.isSumSwapped },
                            callback: { self.isSumSwapped = $0.isSumSwapped })
        store.lazySubscribe(self,
                            selector: { $0.currentRate != $1.currentRate},
                            callback: {
                                if let rate = $0.currentRate {
                                    let placeholderAmount = Amount(amount: 0, rate: rate, maxDigits: $0.maxDigits)
                                    secondaryLabel.formatter = placeholderAmount.localFormat
                                    primaryLabel.formatter = placeholderAmount.sumFormat
                                    
                                }
                                self.exchangeRate = $0.currentRate
                            })
        
        store.lazySubscribe(self,
                            selector: { $0.maxDigits != $1.maxDigits},
                            callback: {
                                if let rate = $0.currentRate {
                                    let placeholderAmount = Amount(amount: 0, rate: rate, maxDigits: $0.maxDigits)
                                    secondaryLabel.formatter = placeholderAmount.localFormat
                                    primaryLabel.formatter = placeholderAmount.sumFormat
                                    self.setBalances()
                                }
                            })
        
        store.subscribe(self,
                        selector: {$0.walletState.balance != $1.walletState.balance },
                        callback: { state in
                            if let balance = state.walletState.balance {
                                self.balance = balance
                                self.setBalances()
                            } })
    }
    
    /// This is called when the price changes
    private func setBalances() {
        guard let rate = exchangeRate, let store = self.store, let isSUMSwapped = self.isSumSwapped else {
            NSLog("ERROR: Rate, Store not initialized")
            return
        }
        guard let primaryLabel = self.primaryBalanceLabel,
              let secondaryLabel = self.secondaryBalanceLabel else {
            NSLog("ERROR: Price labels not initialized")
            return
        }
        
        let amount = Amount(amount: balance, rate: rate, maxDigits: store.state.maxDigits)
        
        if !hasInitialized {
            let amount = Amount(amount: balance, rate: exchangeRate!, maxDigits: store.state.maxDigits)
            NSLayoutConstraint.deactivate(isSUMSwapped ? self.regularConstraints : self.swappedConstraints)
            NSLayoutConstraint.activate(isSUMSwapped ? self.swappedConstraints : self.regularConstraints)
            primaryLabel.setValue(amount.amountForSumFormat)
            secondaryLabel.setValue(amount.localAmount)
            if isSUMSwapped {
                primaryLabel.transform = transform(forView: primaryLabel)
            } else {
                secondaryLabel.transform = transform(forView: secondaryLabel)
            }
            hasInitialized = true
        } else {
            if primaryLabel.isHidden {
                primaryLabel.isHidden = false
            }
            
            if secondaryLabel.isHidden {
                secondaryLabel.isHidden = false
            }
        }
        
        primaryLabel.setValue(amount.amountForSumFormat)
        secondaryLabel.setValue(amount.localAmount)
        
        if !isSUMSwapped {
            primaryLabel.transform = .identity
            secondaryLabel.transform = transform(forView: secondaryLabel)
        } else {
            secondaryLabel.transform = .identity
            primaryLabel.transform = transform(forView: primaryLabel)
        } 
    }
    
    /// Transform SUM and Fiat  Balances
    /// - Parameter forView: Views
    /// - Returns: the inverse transform
    private func transform(forView: UIView) ->  CGAffineTransform {
        forView.transform = .identity
        let scaleFactor: CGFloat = smallFontSize/largeFontSize
        let deltaX = forView.frame.width * (1-scaleFactor)
        let deltaY = forView.frame.height * (1-scaleFactor)
        let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        return scale.translatedBy(x: -deltaX, y: deltaY/2.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        guard let array = self.tabBar.items else {
            NSLog("ERROR: no items found")
            return
        }
        
        array.forEach { item in
            
            switch item.tag {
            case 0: item.title = S.History.barItemTitle
            case 1: item.title = S.Send.barItemTitle
            case 2: item.title = S.SumcoinCard.barItemTitle
            case 3: item.title = S.Receive.barItemTitle
            case 4: item.title = S.BuyCenter.barItemTitle
            default:
                item.title = "NO-TITLE"
                NSLog("ERROR: UITabbar item count is wrong")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayContentController(contentController: viewControllers[kInitialChildViewControllerIndex])
    }
    
    func displayContentController(contentController:UIViewController) {
        
        //MARK: - Tab View Controllers Configuration
        switch NSStringFromClass(contentController.classForCoder) {
            case "loafwallet.TransactionsViewController":
                
                guard let transactionVC = contentController as? TransactionsViewController else  {
                    return
                }
                
                transactionVC.store = self.store
                transactionVC.walletManager = self.walletManager
                transactionVC.isSumSwapped = self.store?.state.isSumSwapped
                
            case "loafwallet.CardViewController":
                guard let cardVC = contentController as? CardViewController else  {
                    return
                }
                
                cardVC.parentFrame = self.containerView.frame
				
            case "loafwallet.BuyTableViewController":
                guard let buyVC = contentController as? BuyTableViewController else  {
                    return
                }
                buyVC.store = self.store
                buyVC.walletManager = self.walletManager
                
            case "loafwallet.SendSUMViewController":
                guard let sendVC = contentController as? SendSUMViewController else  {
                    return
                }
                
                sendVC.store = self.store
                
            case "loafwallet.ReceiveSUMViewController":
                guard let receiveVC = contentController as? ReceiveSUMViewController else  {
                    return
                }
                receiveVC.store = self.store
                
            default:
                fatalError("Tab viewController not set")
        }
        self.exchangeRate = TransactionManager.sharedInstance.rate
        
        self.addChildViewController(contentController)
        contentController.view.frame = self.containerView.frame
        self.view.addSubview(contentController.view)
        contentController.didMove(toParentViewController: self)
        self.activeController = contentController
    }
    
    func hideContentController(contentController:UIViewController) {
        contentController.willMove(toParentViewController: nil)
        contentController.view .removeFromSuperview()
        contentController.removeFromParentViewController()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if let tempActiveController = activeController {
            self.hideContentController(contentController: tempActiveController)
        }
        
        //DEV: This happens because it relies on the tab in the storyboard tag
        self.displayContentController(contentController: viewControllers[item.tag])
    }
}

extension TabBarViewController {
    
    @objc private func currencySwitchTapped() {
        self.view.layoutIfNeeded()
        guard let store = self.store else { return }
        guard let isSUMSwapped = self.isSumSwapped else { return }
        guard let primaryLabel = self.primaryBalanceLabel,
              let secondaryLabel = self.secondaryBalanceLabel else {
            NSLog("ERROR: Price labels not initialized")
            return
        }
        
        UIView.spring(0.7, animations: {
            primaryLabel.transform = primaryLabel.transform.isIdentity ? self.transform(forView: primaryLabel) : .identity
            secondaryLabel.transform = secondaryLabel.transform.isIdentity ? self.transform(forView: secondaryLabel) : .identity
            NSLayoutConstraint.deactivate(!isSUMSwapped ? self.regularConstraints : self.swappedConstraints)
            NSLayoutConstraint.activate(!isSUMSwapped ? self.swappedConstraints : self.regularConstraints)
            self.view.layoutIfNeeded()
            
            LWAnalytics.logEventWithParameters(itemName: ._20200207_DTHB)
            
        }) { _ in }
        store.perform(action: CurrencyChange.toggle())
    }
}
