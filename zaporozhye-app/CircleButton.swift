//
//  CircleButton.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/3/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.width / 2
    }

}
