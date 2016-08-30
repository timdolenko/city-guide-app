//
//  Food.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

class Food {
    
    private var _name: String!
    private var _menu: String!
    private var _phones: [String]!
    private var _imgPath: String!
    private var _timeOpen: Int!
    private var _timeClose: Int!
    
    var name: String {
        return _name
    }
    
    var menu: String! {
        return _menu
    }
    
    var phones: [String] {
        return _phones
    }
    
    var imgPath: String {
        return _imgPath
    }
    
    var timeOpen: Int {
        return _timeOpen
    }
    
    var timeClose: Int {
        return _timeClose
    }
    
    func isFoodServiceOpen() -> Bool {
        let now = Date()
        let openTime = now.dateAt(hours: self.timeOpen, minutes: 0)
        let closeTime = now.dateAt(hours: self.timeClose, minutes: 0)
        if now >= openTime && now <= closeTime {
            return true
        } else {
            return false
        }
    }
    
}
