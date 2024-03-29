//
//  RoundedView.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/27/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 20.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 1).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.75
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }

}
