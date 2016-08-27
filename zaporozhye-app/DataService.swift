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
    
    // Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("places-pics")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_PLACES: FIRDatabaseReference {
        return _REF_PLACES
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
    func getPlacesData() -> [Place] {
        if let placesData = UserDefaults.standard.object(forKey: KEY_PLACES_DATA) as? Data {
            
            if let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData) as? [Place] {
                print("SISPO: Successfully get places array from local data.")
                return placesArray
            }
        } else {
            print("SISPO: Failed to get places array from local data. Returning empty array")
        }
        
        return [Place]()
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
                print("SISPO: Successfully downcasted geoLoc dictionary")
                
                let place = Place(name: name, placeDesc: placeDesc, drink: drink, walk: walk, eat: eat, smoke: smoke, lat: lat, lon: lon, phone: phone, imgPaths: imgPaths)
                return place
            } else {
                print("SISPO: Error while downcasting geoLoc")
            }
        } else {
            print("SISPO: Error while downcasting snapData")
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

    
}

