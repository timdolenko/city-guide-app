//
//  MaterialButton.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/24/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 1).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }

}
