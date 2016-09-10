//
//  Food.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

class Food: NSObject, NSCoding {
    
    private var _name: String!
    private var _menu: String!
    private var _phones: [String]!
    private var _imgPath: String!
    private var _timeOpen: Int!
    private var _timeClose: Int!
    private var _website: URL!
    
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
    
    var website: URL {
        return _website
    }
    
    init(name: String, menu: String, phones: [String], imgPath: String, timeOpen: Int, timeClose: Int, website: URL) {
        _name = name
        _menu = menu
        _phones = phones
        _imgPath = imgPath
        _timeOpen = timeOpen
        _timeClose = timeClose
        _website = website
    }
    
    func isFoodServiceOpen() -> Bool {
        if Date.timeIsBetween(startHour: timeOpen, endHour: timeClose) {
            print("SISPO: Food service \(name) is open")
            return true
        } else {
            print("SISPO: Food service \(name) is closed")
            return false
        }
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let name = aDecoder.decodeObject(forKey: "name") as? String,
            let menu = aDecoder.decodeObject(forKey: "menu") as? String,
            let phones = aDecoder.decodeObject(forKey: "phones") as? [String],
            let imgPath = aDecoder.decodeObject(forKey: "imgPath") as? String,
            let timeOpen = aDecoder.decodeObject(forKey: "timeOpen") as? Int,
            let timeClose = aDecoder.decodeObject(forKey: "timeClose") as? Int,
            let website = aDecoder.decodeObject(forKey: "website") as? URL {
            
            _name = name
            _menu = menu
            _phones = phones
            _imgPath = imgPath
            _timeOpen = timeOpen
            _timeClose = timeClose
            _website = website
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: "name")
        aCoder.encode(_menu, forKey: "menu")
        aCoder.encode(_phones, forKey: "phones")
        aCoder.encode(_imgPath, forKey: "imgPath")
        aCoder.encode(_timeOpen, forKey: "timeOpen")
        aCoder.encode(_timeClose, forKey: "timeClose")
        aCoder.encode(_website, forKey: "website")
    }
    
    
}
