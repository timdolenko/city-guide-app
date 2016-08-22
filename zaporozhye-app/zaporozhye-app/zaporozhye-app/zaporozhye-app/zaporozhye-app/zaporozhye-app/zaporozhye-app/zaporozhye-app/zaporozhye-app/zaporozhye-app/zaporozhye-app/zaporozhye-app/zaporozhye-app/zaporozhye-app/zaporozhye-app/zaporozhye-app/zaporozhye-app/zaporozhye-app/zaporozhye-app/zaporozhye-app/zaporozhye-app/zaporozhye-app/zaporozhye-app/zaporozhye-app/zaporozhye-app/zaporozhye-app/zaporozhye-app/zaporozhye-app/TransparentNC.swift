//
//  TransparentNC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class TransparentNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), forBarMetrics:UIBarMetrics.Default)
        navigationBar.translucent = true
        navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated:true)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    



}
