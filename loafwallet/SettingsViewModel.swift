//
//  SettingsViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 10/18/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    
    /// Presents a sheet using the given item as a data source
    /// for the sheet's content.
    ///
    /// - Parameters:
    ///   - preferredLanguage: The readable string of preferred language
    ///   - displayCurrency: The readable string of preferred currency
    ///   - store: The runtime object that carries state

    var preferredLanguage: String {
        get {
            let langName = Locale.preferredLanguages.first ?? "en"
            let locale =  NSLocale(localeIdentifier: langName)
            return locale.localizedString(forLanguageCode: langName) ?? "English"
        }
    }
    
    var displayCurrency: String {
        get {
            return self.store.state.defaultCurrencyCode
        }
    }
    
    private let store: Store
    
    init(store: Store) {
        self.store = store
    }
}

