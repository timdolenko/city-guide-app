//
//  MoreVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/5/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}
