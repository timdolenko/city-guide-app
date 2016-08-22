//
//  Taxi.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation


class Taxi {
    
    private var _phones: [String]
    private var _name: String
    
    var phones: [String] {
        return _phones
    }
    
    var name: String {
        return _name
    }
    
    init(phones: [String], name: String) {
        _phones = phones
        _name = name
    }
    
}
