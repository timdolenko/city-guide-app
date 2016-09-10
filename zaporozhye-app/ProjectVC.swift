//
//  ProjectVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/4/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let background = CAGradientLayer().mainColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
    }
    

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}
