//
//  MaterialView.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class MaterialView: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 0.0
        layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1).cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
    }
    
}
