//
//  DataService.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/25/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation
import Firebase

let ref = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    static let ds = DataService()
    
    var placesImages = [String: UIImage]()
    var placesData = [Place]()
    
    // DB references
    private var _REF_BASE = ref
    private var _REF_PLACES = ref.child("Places")
    private var _REF_TAXI = ref.child("Taxi")
    
    // Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("places-pics")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_PLACES: FIRDatabaseReference {
        return _REF_PLACES
    }
    
    var REF_TAXI: FIRDatabaseReference {
        return _REF_TAXI
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
    //Places Service
    
    var placesArray = [Place]()
    
    func getPlacesData() {
        if let placesData = UserDefaults.standard.object(forKey: KEY_PLACES_DATA) as? Data {
            
            if let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData) as? [Place] {
                print("SISPO: Successfully get places array from local data.")
                self.placesArray = placesArray
            }
        } else {
            print("SISPO: Failed to get places array from local data. Returning empty array")
        }
        
        if placesArray.count == 0 {
            DataService.ds.REF_PLACES.observe(.value, with: { snapshot in
                print(snapshot.value)
                DataService.ds.getPlacesArrayFrom(snapshot: snapshot)
            })
        }
    }
    
    func getPlacesArrayFrom(snapshot: FIRDataSnapshot) {
        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
            for snap in snapshots {
                print("SNAP: \(snap)")
                
                if let placeDict = snap.value as? Dictionary<String, AnyObject> {
                    let place = DataService.ds.convertSnapToPlaceObject(snapData: placeDict)
                    self.placesArray.append(place)
                }
            }
            
            DataService.ds.saveToLocalData(arrayOfPlaces: self.placesArray)
        }
    }
    
    func saveToLocalData(arrayOfPlaces: [Place]) {
        let placesData = NSKeyedArchiver.archivedData(withRootObject: arrayOfPlaces)
        UserDefaults.standard.set(placesData, forKey: KEY_PLACES_DATA)
        UserDefaults.standard.synchronize()
        print("SISPO: Successfully saved array of places")
        
    }
    
    func convertSnapToPlaceObject(snapData: Dictionary<String,AnyObject>) -> Place {
        if let name = snapData["name"] as? String,
        let placeDesc = snapData["description"] as? String,
        let smoke = snapData["smoke"] as? Bool,
        let drink = snapData["drink"] as? Bool,
        let eat = snapData["eat"] as? Bool,
        let walk = snapData["walk"] as? Bool,
        let phone = snapData["phone"] as? String,
        let imgPaths = snapData["imgPaths"] as? Array<String>,
            let geoLoc = snapData["geoLoc"] as? Dictionary<String,Double> {
            print("SISPO: Successfully downcasted snapData")
            if let lat = geoLoc["lat"], let lon = geoLoc["lon"] {
                print("SISPO: Successfully downcasted geoLoc dictionary with lat: \(lat) and lon: \(lon)")
                
                let place = Place(name: name, placeDesc: placeDesc, drink: drink, walk: walk, eat: eat, smoke: smoke, lat: lat, lon: lon, phone: phone, imgPaths: imgPaths)
                return place
            } else {
                print("SISPO: Error while downcasting geoLoc")
            }
        } else {
            print("SISPO: Error while downcasting place snapData")
        }

        
        return Place()
    }
    
    func saveToLocalData(img: UIImage, with imgPath:String) {
        let imgData = UIImageJPEGRepresentation(img, 0.8)
        
        let fileURL = documentsURLForFileName(name: imgPath)
        
        do {
            try imgData?.write(to: fileURL, options: .atomic)
            print("SISPO: Successfully saved image with path: \(imgPath)")
        } catch {
            print(error)
        }
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsURLForFileName(name: path)
        do {
            let imgData = try Data(contentsOf: fullPath)
            let image = UIImage(data: imgData)
            print("SISPO: Successfully get image for path: \(path)")
            return image
        } catch {
            print("SISPO: Error occured: \(error), while getting image for path \(path)")
        }
        
        return nil
        
    }
    
    func documentsURLForFileName(name: String) -> URL {
        let fileURL = try! FileManager.default.urlForDirectory(.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
        return fileURL
    }
    
    //Taxi Service
    
    var taxiArray = [Taxi]()
    
    func getTaxiArrayFrom(snapshot: FIRDataSnapshot) {
        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
            for snap in snapshots {
                print("SNAP: \(snap)")
                
                if let taxiDict = snap.value as? Dictionary<String, AnyObject> {
                    let taxi = DataService.ds.convertSnapToTaxiObject(snapData: taxiDict)
                    self.taxiArray.append(taxi)
                }
            }
            
            DataService.ds.saveToLocalData(arrayOfTaxi: self.taxiArray)
            
        }
    }

    func convertSnapToTaxiObject(snapData: Dictionary<String,AnyObject>) -> Taxi {
        if let name = snapData["name"] as? String,
            let phones = snapData["phones"] as? Array<String> {
            let taxi = Taxi(phones: phones, name: name)
            print("SISPO: Successfully downcasted taxi snapData with name: \(name)")
            return taxi
        } else {
            print("SISPO: Error while downcasting taxi snapData")
        }
        
        
        return Taxi(phones: [""], name: "")
    }
    
    func saveToLocalData(arrayOfTaxi: [Taxi]) {
        let taxiData = NSKeyedArchiver.archivedData(withRootObject: arrayOfTaxi)
        UserDefaults.standard.set(taxiData, forKey: KEY_TAXI_DATA)
        UserDefaults.standard.synchronize()
        print("SISPO: Successfully saved array of taxi")
        
    }
    
    func getTaxiData() {
        if let taxiData = UserDefaults.standard.object(forKey: KEY_TAXI_DATA) as? Data {
            
            if let taxiArray = NSKeyedUnarchiver.unarchiveObject(with: taxiData) as? [Taxi] {
                print("SISPO: Successfully get taxi array from local data.")
                self.taxiArray = taxiArray
            }
        } else {
            print("SISPO: Failed to get taxi array from local data. Returning empty array")
        }
        
        if self.taxiArray.count == 0 {
            DataService.ds.REF_TAXI.observe(.value, with: { snapshot in
                print(snapshot.value)
                self.getTaxiArrayFrom(snapshot: snapshot)
            })
        }
    }
    
    //Call service
    
    func call(phone: String) {
        
        //Creating a valid number for call by removing invalid chars
        
        var newPhone = ""
        
        for x in 0..<phone.characters.count {
            switch phone[phone.index(phone.startIndex, offsetBy: x)] {
            case "0","1","2","3","4","5","6","7","8","9","+":
                newPhone = newPhone + String(phone[phone.index(phone.startIndex, offsetBy: x)])
            default:
                print("SISPO: Removed invalid char from phone number")
            }
            
        }
        
        print("SISPO: Valid phone: \(newPhone)")
        
        if let url = URL(string: "tel://\(newPhone)") {
            UIApplication.shared().openURL(url)
        }
    }
    
    
}

