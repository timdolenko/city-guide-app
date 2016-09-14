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
    private var _nameRu: String!
    
    var phones: [String] {
        return _phones
    }
    
    var name: String {
        return _name
    }
    
    var nameRu: String {
        return _nameRu
    }
    
    init(phones: [String], name: String, nameRu: String) {
        _phones = phones
        _name = name
        _nameRu = nameRu
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let nameRu = aDecoder.decodeObject(forKey: "nameRu") as? String,
            let phones = aDecoder.decodeObject(forKey: "phones") as? Array<String>
            else { return nil }
        
        _name = name
        _nameRu = nameRu
        _phones = phones
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: "name")
        aCoder.encode(_nameRu, forKey: "nameRu")
        aCoder.encode(_phones, forKey: "phones")
    }
    
}
