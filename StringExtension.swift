//
//  StringExtension.swift
//  PokeWeather
//
//  Created by Kauê Sales on 03/03/21.
//

import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
