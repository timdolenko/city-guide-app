//
//  PlacesVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/24/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import Firebase

class PlacesMenuVC: UIViewController {
    
    var placesArray = [Place]()
    var isPlaceArrayReady = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesArray = DataService.ds.getPlacesData()
        
        if placesArray.count == 0 {
            DataService.ds.REF_PLACES.observe(.value, with: { snapshot in
                print(snapshot.value)
                
                self.placesArray = []
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    
                    for snap in snapshots {
                        print("SNAP: \(snap)")
                        
                        if let placeDict = snap.value as? Dictionary<String, AnyObject> {
                            let place = DataService.ds.convertSnapToPlaceObject(snapData: placeDict)
                            self.placesArray.append(place)
                        }
                    }
                    
                    DataService.ds.saveToLocalData(arrayOfPlaces: self.placesArray)
                    
                    
                    self.isPlaceArrayReady = true
                }
            })
        } else {
            self.isPlaceArrayReady = true
        }
    }
    

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func eatBtnPressed(_ sender: AnyObject) {
        performSegueWithFilteredArrayOf(type: KEY_EAT)
    }
    
    @IBAction func drinkBtnPressed(_ sender: AnyObject) {
        performSegueWithFilteredArrayOf(type: KEY_DRINK)
    }

    @IBAction func smokeBtnPressed(_ sender: AnyObject) {
        performSegueWithFilteredArrayOf(type: KEY_SMOKE)
    }
    
    @IBAction func walkBtnPressed(_ sender: AnyObject) {
        performSegueWithFilteredArrayOf(type: KEY_WALK)
    }

    @IBAction func questionBtnPressed(_ sender: AnyObject) {
        
    }
    
    func performSegueWith(dict: Dictionary<String,AnyObject>) {
        performSegue(withIdentifier: SEGUE_PLACESVC, sender: dict)
    }
    
    func performSegueWithFilteredArrayOf(type: String) {
        
        var filteredPlaces = [Place]()
        
        var dict: Dictionary<String, AnyObject> = ["title":""]
        
        if isPlaceArrayReady {
            
                switch type {
                case KEY_EAT:
                    filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                        place.eat
                    })
                    dict["title"] = "Eat"
                    dict["places"] = filteredPlaces
                    performSegueWith(dict: dict)
                case KEY_WALK:
                    filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                        place.walk
                    })
                    dict["title"] = "Walk"
                    dict["places"] = filteredPlaces
                    performSegueWith(dict: dict)
                case KEY_DRINK:
                    filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                        place.drink
                    })
                    dict["title"] = "Drink"
                    dict["places"] = filteredPlaces
                    performSegueWith(dict: dict)
                case KEY_SMOKE:
                    filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                        place.smoke
                    })
                    dict["title"] = "Smoke"
                    dict["places"] = filteredPlaces
                    performSegueWith(dict: dict)
                default:
                    print("SISPO: Error filtering places array")
                }

        } else {
            let alert = UIAlertController(title: "Please wait", message: "Downloading data from internet", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_PLACESVC {
            if let placesVC = segue.destinationViewController as? PlacesVC {
                if let dict = sender as? Dictionary<String,AnyObject> {
                    if let placesArray = dict["places"] as? [Place] {
                        placesVC.placesArray = placesArray
                    } else {
                        print("SISPO: Error in placesArray")
                    }
                    if let title = dict["title"] as? String {
                        placesVC.placesTitle = title
                    } else {
                        print("SISPO: Error in places title")
                    }
                } else {
                    print("SISPO: Error in places dictionary")
                }
            } else {
                print("SISPO: Error in places ViewController")
            }
        }
    }
    
    
}
