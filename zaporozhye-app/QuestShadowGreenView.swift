//
//  QuestShadowGreenView.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/4/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class QuestShadowGreenView: UIView {

    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
    }
}
