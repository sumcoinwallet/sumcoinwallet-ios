[![Sumcoin Wallet](/images/header-ios.png)](https://itunes.apple.com/us/app/loafwallet/id1119332592)
======================================= 

[![Release](https://img.shields.io/github/v/release/sumcoinwallet/sumcoinwallet-ios?style=flat)](https://img.shields.io/github/v/release/sumcoinwallet/sumcoinwallet-ios) 


<<<<<<< HEAD
[![Build Status](https://app.bitrise.io/app/3c3c3f9830a3bac7/status.svg?token=zisOsG_I-9nSfT3c1FML7w)](https://app.bitrise.io/app/3c3c3f9830a3bac7)
[![GitHub issues](https://img.shields.io/github/issues/sumcoinwallet/sumcoinwallet-ios?style=flat)](https://github.com/sumcoinwallet/sumcoinwallet-ios/re-frame/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/sumcoinwallet/sumcoinwallet-ios?color=00ff00&style=flat)](https://github.com/sumcoinwallet/sumcoinwallet-ios/pulls)
 
[![MIT License](https://img.shields.io/github/license/sumcoinwallet/sumcoinwallet-ios?style=flat)](https://img.shields.io/github/license/sumcoinwallet/sumcoinwallet-ios?style=flat)

-------------------------------------
## Easy and secure
Sumcoin Wallet is the best way to get started with Sumcoin. Our simple, streamlined design is easy for beginners, yet powerful enough for experienced users. This is a free app produced by the Sumcoin Wallet.
=======
>>>>>>> parent of 85bfab43 (moved donations)

|                                   Hardware Campaign                                   	|                              General Sumcoin Wallet                              	|
|:-------------------------------------------------------------------------------------:	|:-------------------------------------------------------------------------------------:	|
| [QR Code](https://blockchair.com/sumcoin/address/MJ4W7NZya4SzE7R6xpEVdamGCimaQYPiWu) 	| [QR Code](https://blockchair.com/sumcoin/address/MVZj7gBRwcVpa9AAWdJm8A3HqTst112eJe) 	|


### The easy and secure Sumcoin wallet

Sumcoin Wallet is the best way to get started with Sumcoin. Our simple, streamlined design is easy for beginners, yet powerful enough for experienced users. This is a free app produced by the Sumcoin Wallet.

iOS Users can visit the iOS version of the code here: [Sumcoin Wallet iOS](https://github.com/sumcoinwallet/sumcoinwallet-ios) 

### Completely decentralized

Unlike other iOS Sumcoin wallets, **Sumcoin Wallet** is a standalone Sumcoin client. It connects directly to the Sumcoin network using [SPV](https://en.bitcoin.it/wiki/Thin_Client_Security#Header-Only_Clients) mode, and doesn't rely on servers that can be hacked or disabled. Even if Sumcoin Wallet is removed from the App Store, the app will continue to function, allowing users to access their valuable Sumcoin at any time.

### Cutting-edge security

**Sumcoin Wallet** utilizes AES hardware encryption, app sandboxing, and the latest iOS security features to protect users from malware, browser security holes, and even physical theft. Private keys are stored only in the secure enclave of the user's phone, inaccessible to anyone other than the user.

### Designed with new users in mind

Simplicity and ease-of-use is **Sumcoin Wallet**'s core design principle. A simple recovery phrase (which we call a paper key) is all that is needed to restore the user's wallet if they ever lose or replace their device. **Sumcoin Wallet** is [deterministic](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki), which means the user's balance and transaction history can be recovered just from the paper key.

### Features:

- ["simplified payment verification"](https://github.com/bitcoin/bips/blob/master/bip-0037.mediawiki) for fast mobile performance
- no server to get hacked or go down
- single backup phrase that works forever
- private keys never leave your device
- import [password protected](https://github.com/bitcoin/bips/blob/master/bip-0038.mediawiki) paper wallets
- ["payment protocol"](https://github.com/bitcoin/bips/blob/master/bip-0070.mediawiki) payee identity certification


### Localization

**Sumcoin Wallet** is available in the following languages:

- Chinese (Simplified and traditional)
- Danish
- Dutch
- English
- French
- German
- Italian
- Japanese
- Korean
- Portuguese
- Russian
- Spanish
- Swedish
 
---
<<<<<<< HEAD
## Sumcoin Wallet Development:
=======
### Sumcoin Wallet Development:
[![GitHub issues](https://img.shields.io/github/issues/sumcoinwallet/sumcoinwallet-ios?style=plastic)](https://github.com/sumcoinwallet/sumcoinwallet-ios/re-frame/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/sumcoinwallet/sumcoinwallet-ios?color=00ff00&style=plastic)](https://github.com/sumcoinwallet/sumcoinwallet-ios/pulls)
>>>>>>> parent of 85bfab43 (moved donations)

### Building & Developing Sumcoin Wallet for iOS:
***Installation on jailbroken devices is strongly discouraged.***

Any jailbreak app can grant itself access to every other app's keychain data. This means it can access your wallet and steal your Sumcoin by self-signing as described [here](http://www.saurik.com/id/8) and including `<key>application-identifier</key><string>*</string>` in its .entitlements file.

1. Download and install Cocoapods to your Mac computer: `sudo gem install cocoapods`
2. Download and install the latest version of [Xcode](https://developer.apple.com/xcode/)
3. Clone this repo & init submodules
```bash
$ git clone https://github.com/sumcoinwallet/sumcoinwallet-ios
$ git submodule init
$ git submodule update
```
4. From the root where the Podfile is located, install the pods: `pod install`
5. From the root where the *Xcode Workspace* is located, open the project: `open loafwallet.xcworkspace`
 
### Sumcoin Wallet Team:
* [Development Code of Conduct](/development.md)
---
**Sumcoin** source code is available at https://github.com/sumcoin-project/sumcoin
