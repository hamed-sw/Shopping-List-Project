//
//  Extenstion.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 28.03.2021.
//

import Foundation
var languagekey = "languagekey"
extension String {

    func localizableString() -> String {
        var defaultLanguage = "en"
        if let selectedlanguage = UserDefaults.standard.string(forKey: languagekey){
            defaultLanguage = selectedlanguage
        }
         let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj")
           let bundle = Bundle(path: path!)
            
            return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: "", comment: "")
    }
}
