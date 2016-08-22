//
//  TaxiService.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

class TaxiService {
    
    static func getArrayOfTaxi(database: Dictionary<String,NSDictionary>) -> [Taxi] {
        var taxiArray = [Taxi]()
        
        for x in 0...database.count {
            if let dict = database["TaxiDict\(x)"] {
                if let name = dict["name"] as? String, let phones = dict["phones"] as? [String] {
                    let taxi = Taxi(phones: phones, name: name)
                    taxiArray.append(taxi)
                }
            }
        }
        
        return taxiArray
    }
    
    static func callTaxi(phone: String) {
        
        //Creating a valid number for call by removing invalid chars
        
        var newPhone = ""
        
        for x in 0..<phone.characters.count {
            switch phone[phone.index(phone.startIndex, offsetBy: x)] {
            case "0","1","2","3","4","5","6","7","8","9","+":
                newPhone = newPhone + String(phone[phone.index(phone.startIndex, offsetBy: x)])
            default:
                print("Removed invalid char from phone number")
            }
            
        }
        
        print("valid phone: \(newPhone)")
        
        if let url = URL(string: "tel://\(newPhone)") {
            UIApplication.shared().openURL(url)
        }
    }

    
    
}
