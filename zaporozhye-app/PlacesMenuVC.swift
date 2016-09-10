//
//  PlacesVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/24/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import Firebase

class PlacesMenuVC: ProjectVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func eatBtnPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: SEGUE_PLACESVC, sender: KEY_EAT)
    }
    
    @IBAction func drinkBtnPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: SEGUE_PLACESVC, sender: KEY_DRINK)
    }

    @IBAction func smokeBtnPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: SEGUE_PLACESVC, sender: KEY_SMOKE)
    }
    
    @IBAction func walkBtnPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: SEGUE_PLACESVC, sender: KEY_WALK)
    }

    @IBAction func questionBtnPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: SEGUE_QUESTVC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_PLACESVC {
            if let placesVC = segue.destination as? PlacesVC {
                if let type = sender as? String {
                    placesVC.type = type
                } else {
                    print("SISPO: Error in places type")
                }
            } else {
                print("SISPO: Error in places ViewController")
            }
        }
    }
    
    
}
