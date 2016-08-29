//
//  Taxi.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation


class Taxi: NSObject, NSCoding {
    
    private var _phones: [String]!
    private var _name: String!
    
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
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let phones = aDecoder.decodeObject(forKey: "phones") as? Array<String>
            else { return nil }
        
        _name = name
        _phones = phones
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: "name")
        aCoder.encode(_phones, forKey: "phones")
    }
    
}
