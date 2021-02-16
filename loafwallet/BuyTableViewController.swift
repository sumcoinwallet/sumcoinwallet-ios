//
//  BuyTableViewController.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/18/19.
//  Copyright © 2019 Litecoin Foundation. All rights reserved.
//

import UIKit

enum PartnerName {
    case simplex
    case moonpay
}

class BuyTableViewController: UITableViewController { 
   
    //MARK: Moonpay UI
    @IBOutlet weak var moonpayLogoImageView: UIImageView!
    @IBOutlet weak var moonpayHeaderLabel: UILabel!
    @IBOutlet weak var moonpayDetailsLabel: UILabel!
    @IBOutlet weak var moonpayCellContainerView: UIView!
    @IBOutlet weak var moonpaySegmentedControl: UISegmentedControl!
    
    @IBAction func didTapMoonpay(_ sender: Any) {
        
        if let vcWKVC = UIStoryboard.init(name: "Buy", bundle: nil).instantiateViewController(withIdentifier: "BuyWKWebViewController") as? BuyWKWebViewController {
            vcWKVC.partnerName = .moonpay
            vcWKVC.currencyCode = currencyCode
            addChildViewController(vcWKVC)
            self.view.addSubview(vcWKVC.view)
            vcWKVC.didMove(toParentViewController: self)
            
            vcWKVC.didDismissChildView = {
                vcWKVC.willMove(toParentViewController: nil)
                vcWKVC.view.removeFromSuperview()
                vcWKVC.removeFromParentViewController()
            }
        }  else {
            NSLog("ERROR: Storyboard not initialized")
        }
    }
    
    //MARK: Simplex UI
    @IBOutlet weak var simplexLogoImageView: UIImageView!
    @IBOutlet weak var simplexHeaderLabel: UILabel!
    @IBOutlet weak var simplexDetailsLabel: UILabel!
    @IBOutlet weak var simplexCellContainerView: UIView!
    @IBOutlet weak var simplexCurrencySegmentedControl: UISegmentedControl!
    
    private var currencyCode: String = "USD"
    
    @IBAction func didTapSimplex(_ sender: Any) {
        
        if let vcWKVC = UIStoryboard.init(name: "Buy", bundle: nil).instantiateViewController(withIdentifier: "BuyWKWebViewController") as? BuyWKWebViewController { 
            vcWKVC.partnerName = .simplex 
            vcWKVC.currencyCode = currencyCode
            addChildViewController(vcWKVC)
            self.view.addSubview(vcWKVC.view)
            vcWKVC.didMove(toParentViewController: self)
           
            vcWKVC.didDismissChildView = {
                for vc in self.childViewControllers {
                    DispatchQueue.main.async {
                        vc.willMove(toParentViewController: nil)
                        vc.view.removeFromSuperview()
                        vc.removeFromParentViewController()
                    }
                }
            }
            
        }  else {
            NSLog("ERROR: Storyboard not initialized")
        }
    }
    
    var store: Store?
    var walletManager: WalletManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thinHeaderView = UIView()
        thinHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0)
        thinHeaderView.backgroundColor = .white
        tableView.tableHeaderView = thinHeaderView
        tableView.tableFooterView = UIView()
        
        moonpaySegmentedControl.addTarget(self, action: #selector(didChangeCurrencyA), for: .valueChanged)
        moonpaySegmentedControl.selectedSegmentIndex = PartnerFiatOptions.usd.index
        moonpaySegmentedControl.selectedSegmentTintColor = .white
        moonpaySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        moonpaySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.liteWalletBlue], for: .selected)
        
        simplexCurrencySegmentedControl.addTarget(self, action: #selector(didChangeCurrencyB), for: .valueChanged)
        simplexCurrencySegmentedControl.selectedSegmentIndex = PartnerFiatOptions.usd.index
        simplexCurrencySegmentedControl.selectedSegmentTintColor = .white
        simplexCurrencySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        simplexCurrencySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.liteWalletBlue], for: .selected)
        
        setupData()
    }
    
    private func setupData() {
        
        let moonpayData = Partner.partnerDataArray()[0]
        moonpayLogoImageView.image = moonpayData.logo
        moonpayHeaderLabel.text = moonpayData.headerTitle
        moonpayDetailsLabel.text = moonpayData.details
        moonpayCellContainerView.layer.cornerRadius = 6.0
        moonpayCellContainerView.layer.borderColor = UIColor.white.cgColor
        moonpayCellContainerView.layer.borderWidth = 1.0
        moonpayCellContainerView.clipsToBounds = true
        
        let simplexData = Partner.partnerDataArray()[1]
        simplexLogoImageView.image = simplexData.logo
        simplexHeaderLabel.text = simplexData.headerTitle
        simplexDetailsLabel.text = simplexData.details
        simplexCellContainerView.layer.cornerRadius = 6.0
        simplexCellContainerView.layer.borderColor = UIColor.white.cgColor
        simplexCellContainerView.layer.borderWidth = 1.0
        simplexCellContainerView.clipsToBounds = true
    }
    
    @objc private func didChangeCurrencyA() {
        if let code = PartnerFiatOptions(rawValue: moonpaySegmentedControl.selectedSegmentIndex)?.description {
            self.currencyCode = code
        } else {
            print("Error: Code not found: XXXX\(moonpaySegmentedControl.selectedSegmentIndex)")
        }
    }
    
    @objc private func didChangeCurrencyB() {
        if let code = PartnerFiatOptions(rawValue: simplexCurrencySegmentedControl.selectedSegmentIndex)?.description {
            self.currencyCode = code
        } else {
            print("Error: Code not found: XXXX\(simplexCurrencySegmentedControl.selectedSegmentIndex)")
        }
    }
}
