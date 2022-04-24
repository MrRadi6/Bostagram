//
//  String+Extension.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
