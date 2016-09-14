//
//  Place.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/25/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation
import Firebase


class Place: NSObject, NSCoding {
    
    private var _name: String!
    private var _placeDescription: String!
    private var _drink: Bool?
    private var _eat: Bool?
    private var _smoke: Bool?
    private var _walk: Bool?
    private var _geoLocLat: Double!
    private var _geoLocLon: Double!
    private var _phone: String?
    private var _imgPaths: [String]!
    private var _website: URL?
    
    var website: URL? {
        return _website
    }
    
    var name: String {
        return _name
    }
    
    var placeDescription: String {
        return _placeDescription
    }
    
    var drink: Bool? {
        return _drink
    }
    
    var eat: Bool? {
        return _eat
    }
    
    var smoke: Bool? {
        return _smoke
    }
    
    var walk: Bool? {
        return _walk
    }
    
    var geoLocLat: Double {
        return _geoLocLat
    }
    
    var geoLocLon: Double {
        return _geoLocLon
    }
    
    var phone: String? {
        return _phone
    }
    
    var imgPaths: [String] {
        return _imgPaths
    }
    
    init(name: String, placeDesc: String, drink: Bool, walk: Bool, eat: Bool, smoke: Bool, lat: Double, lon: Double, phone: String?, imgPaths: [String]) {
        _name = name
        _placeDescription = placeDesc
        
        if let phone = phone {
            _phone = phone
        } else {
            _phone = ""
        }
        _imgPaths = imgPaths
        
        _drink = drink
        _walk = walk
        _eat = eat
        _smoke = smoke
        
        _geoLocLon = lon
        _geoLocLat = lat
    }
    
    init(name: String, placeDesc: String, lat: Double, lon: Double, phone: String?, imgPaths: [String]) {
        _name = name
        _placeDescription = placeDesc
        
        if let phone = phone {
            _phone = phone
        } else {
            _phone = ""
        }
        _imgPaths = imgPaths
        
        _geoLocLon = lon
        _geoLocLat = lat
    }
    
    init(name: String, placeDesc: String, lat: Double, lon: Double, phone: String?, imgPaths: [String], website: URL) {
        _name = name
        _placeDescription = placeDesc
        
        if let phone = phone {
            _phone = phone
        } else {
            _phone = ""
        }
        _imgPaths = imgPaths
        
        _geoLocLon = lon
        _geoLocLat = lat
        
        
        _website = website
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let name = aDecoder.decodeObject(forKey: "name") as? String,
        let placeDesc = aDecoder.decodeObject(forKey: "description") as? String,
        let geoLocLat = aDecoder.decodeObject(forKey: "geoLocLat") as? Double,
        let geoLocLon = aDecoder.decodeObject(forKey: "geoLocLon") as? Double,
        let imgPaths = aDecoder.decodeObject(forKey: "imgPaths") as? [String] {
            
            self._name = name
            self._placeDescription = placeDesc
            self._geoLocLat = geoLocLat
            self._geoLocLon = geoLocLon
            self._imgPaths = imgPaths
        }
        
        if let phone = aDecoder.decodeObject(forKey: "phone") as? String {
            self._phone = phone
        }
        
        if let drink = aDecoder.decodeObject(forKey: "drink") as? Bool,
        let smoke = aDecoder.decodeObject(forKey: "smoke") as? Bool,
        let eat = aDecoder.decodeObject(forKey: "eat") as? Bool,
        let walk = aDecoder.decodeObject(forKey: "walk") as? Bool {
            
            self._drink = drink
            self._smoke = smoke
            self._eat = eat
            self._walk = walk
        }
        
        if let website = aDecoder.decodeObject(forKey: "website") as? URL {
            self._website = website
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self._name, forKey: "name")
        aCoder.encode(self._placeDescription, forKey: "description")
        aCoder.encode(self._drink, forKey: "drink")
        aCoder.encode(self._walk, forKey: "walk")
        aCoder.encode(self._smoke, forKey: "smoke")
        aCoder.encode(self._eat, forKey: "eat")
        aCoder.encode(self._phone, forKey: "phone")
        aCoder.encode(self._imgPaths, forKey: "imgPaths")
        aCoder.encode(self._geoLocLat, forKey: "geoLocLat")
        aCoder.encode(self._geoLocLon, forKey: "geoLocLon")
        aCoder.encode(self._website, forKey: "website")
    }
}
