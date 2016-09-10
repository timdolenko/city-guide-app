//
//  CAGradientLayerExtension.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/3/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    func mainColor() -> CAGradientLayer {
        let gradientColors: [CGColor] = [VIOLET_COLOR.cgColor, BLUE_COLOR.cgColor]
        let gradientLocations: [NSNumber] = [0.0,1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 0.0035, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.958, y: 0.0035)
        gradientLayer.locations = gradientLocations
        return gradientLayer
    }
    
}
