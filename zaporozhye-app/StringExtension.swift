//
//  StringExtension.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/13/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
