//
//  CircleView.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/4/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.width / 2
    }

}
