//
//  DataService.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/25/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import MapKit

let ref = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    static let ds = DataService()
    
    var placesImages = [String: UIImage]()
    var placesData = [Place]()
    
    // MARK: - DB references -
    private var _REF_BASE = ref
    private var _REF_PLACES = ref.child("Places")
    private var _REF_TAXI = ref.child("Taxi")
    private var _REF_HOTELS = ref.child("Hotels")
    private var _REF_MALLS = ref.child("Malls")
    
    // MARK: - Storage references -
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
    
    var REF_HOTELS: FIRDatabaseReference {
        return _REF_HOTELS
    }
    
    var REF_MALLS: FIRDatabaseReference {
        return _REF_MALLS
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
// MARK: - Places Service -
    
    var placesArray = [Place]()
    
    var hotelsArray = [Place]()
    
    var mallsArray = [Place]()
    
    var taxiArray = [Taxi]()
    
    var foodArray = [Food]()
    
    func getDataFromFirebase() {
        
        self.getLocalDataOf(type: KEY_PLACES)
        self.getLocalDataOf(type: KEY_HOTELS)
        self.getLocalDataOf(type: KEY_MALLS)
        self.getLocalDataOf(type: KEY_TAXI)
        self.getLocalDataOf(type: KEY_FOOD)
        
        if placesArray.count == 0 || hotelsArray.count == 0 || mallsArray.count == 0 || taxiArray.count == 0 || foodArray.count == 0 {
            DataService.ds.REF_BASE.observe(.value, with: { dataDict in
                if let dicts = dataDict.children.allObjects as? [FIRDataSnapshot] {
                    
                    for dict in dicts {
                        if dict.key == "Hotels" {
                            print(dict.value)
                            self.hotelsArray = self.getPlacesArrayFrom(snapshot: dict)
                            DataService.ds.saveToLocalData(arrayOfPlaces: self.hotelsArray, of: KEY_HOTELS)
                        }
                        if dict.key == "Places" {
                            print(dict.value)
                            self.placesArray = DataService.ds.getPlacesArrayFrom(snapshot: dict)
                            DataService.ds.saveToLocalData(arrayOfPlaces: self.placesArray, of: KEY_PLACES)
                        }
                        if dict.key == "Taxi" {
                            print(dict.value)
                            self.taxiArray = DataService.ds.getTaxiArrayFrom(snapshot: dict)
                            DataService.ds.saveToLocalData(arrayOfTaxi: self.taxiArray)
                        }
                        if dict.key == "Malls" {
                            print(dict.value)
                            self.mallsArray = DataService.ds.getPlacesArrayFrom(snapshot: dict)
                            DataService.ds.saveToLocalData(arrayOfPlaces: self.mallsArray, of: KEY_MALLS)
                        }
                        
                        if dict.key == "Food" {
                            print(dict.value)
                            self.foodArray = DataService.ds.getFoodArrayFrom(snapshot: dict)
                            DataService.ds.saveToLocalData(arrayOfFood: self.foodArray)
                        }
                    }
                    
                    
                    NotificationCenter.default.post(Notification(name: Notification.Name("dataLoaded")))
                }
                
            })

        }
        
    }
    
    func getLocalDataOf(type: String) {
        if let data = UserDefaults.standard.object(forKey: type) as? Data {
            switch type {
            case KEY_PLACES:
                if let placesArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Place] {
                    print("SISPO: Successfully got places array of type \(type) from local data.")
                    self.placesArray = placesArray
                }
            case KEY_HOTELS:
                if let hotelsArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Place] {
                    print("SISPO: Successfully got places array of type \(type) from local data.")
                    self.hotelsArray = hotelsArray
                }
            case KEY_MALLS:
                if let mallsArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Place] {
                    print("SISPO: Successfully got places array of type \(type) from local data.")
                    self.mallsArray = mallsArray
                }
            case KEY_TAXI:
                if let taxiArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Taxi] {
                    print("SISPO: Successfully got places array of type \(type) from local data.")
                    self.taxiArray = taxiArray
                }
            case KEY_FOOD:
                if let foodArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Food] {
                    print("SISPO: Successfully got food array")
                    self.foodArray = foodArray
                }
            default:
                print("SISPO: Error occured")
            }

            
        } else {
            print("SISPO: Failed to get data of type \(type) from local data.")
        }
        
    }

    
    func getPlacesArrayFrom(snapshot: FIRDataSnapshot) -> [Place] {
        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
            var array = [Place]()
            
            for snap in snapshots {
                print("SNAP: \(snap)")
                
                if let placeDict = snap.value as? Dictionary<String, AnyObject> {
                    let place = DataService.ds.getPlaceObjectFrom(snapData: placeDict)
                    array.append(place)
                }
            }
            
            return array
        } else {
            print("SISPO: Error occured while getting places array from snapshot")
            return [Place]()
        }
    }
    
    func getFoodArrayFrom(snapshot: FIRDataSnapshot) -> [Food] {
        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
            var array = [Food]()
            
            for snap in snapshots {
                print("SNAP: \(snap)")
                
                if let foodDict = snap.value as? Dictionary<String, AnyObject> {
                    let food = DataService.ds.getFoodObjectFrom(snap: foodDict)
                    array.append(food)
                }
                
            }
            
            return array
            
        } else {
            print("SISPO: Error occured while getting food array from snapshot")
            return [Food]()
        }
    }
    
    func getTaxiArrayFrom(snapshot: FIRDataSnapshot) -> [Taxi] {
        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
            var array = [Taxi]()
            
            for snap in snapshots {
                print("SNAP: \(snap)")
                
                if let taxiDict = snap.value as? Dictionary<String, AnyObject> {
                    let taxi = DataService.ds.getTaxiObjectFrom(snapData: taxiDict)
                    array.append(taxi)
                }
            }
            
            return array
            
        } else {
            print("SISPO: Error occured while getting taxi array from snapshot")
            return [Taxi]()
        }
    }
    
    func getTaxiObjectFrom(snapData: Dictionary<String,AnyObject>) -> Taxi {
        if let name = snapData["name"] as? String,
            let nameRu = snapData["nameRu"] as? String,
            let phones = snapData["phones"] as? Array<String> {
            let taxi = Taxi(phones: phones, name: name, nameRu: nameRu)
            print("SISPO: Successfully downcasted taxi snapData with name: \(name)")
            return taxi
        } else {
            print("SISPO: Error while downcasting taxi snapData")
        }
        
        
        return Taxi(phones: [""], name: "", nameRu: "")
    }
    
    func saveToLocalData(arrayOfPlaces: [Place], of type: String) {
        let placesData = NSKeyedArchiver.archivedData(withRootObject: arrayOfPlaces)
        UserDefaults.standard.set(placesData, forKey: type)
        UserDefaults.standard.synchronize()
        print("SISPO: Successfully saved array of \(type)")
        
    }
    
    func saveToLocalData(arrayOfFood: [Food]) {
        let foodData = NSKeyedArchiver.archivedData(withRootObject: arrayOfFood)
        UserDefaults.standard.set(foodData, forKey: KEY_FOOD)
        UserDefaults.standard.synchronize()
        print("SISPO: Successfully saved array of food")
    }
    
    func saveToLocalData(arrayOfTaxi: [Taxi]) {
        let taxiData = NSKeyedArchiver.archivedData(withRootObject: arrayOfTaxi)
        UserDefaults.standard.set(taxiData, forKey: KEY_TAXI)
        UserDefaults.standard.synchronize()
        print("SISPO: Successfully saved array of taxi")
        
    }
    
    func getPlaceObjectFrom(snapData: Dictionary<String,AnyObject>) -> Place {
        if let name = snapData["name"] as? String,
        let nameRu = snapData["nameRu"] as? String,
        let descRu = snapData["descRu"] as? String,
        let placeDesc = snapData["description"] as? String,
        let imgPaths = snapData["imgPaths"] as? Array<String>,
            let geoLoc = snapData["geoLoc"] as? Dictionary<String,Double> {
            
            print("SISPO: Successfully downcasted snapData with name: \(name)")
            
            if let lat = geoLoc["lat"], let lon = geoLoc["lon"] {
                
                print("SISPO: Successfully downcasted geoLoc dictionary with lat: \(lat) and lon: \(lon)")
                
                let phone = snapData["phone"] as? String
                
                
                if let smoke = snapData["smoke"] as? Bool,
                let drink = snapData["drink"] as? Bool,
                let eat = snapData["eat"] as? Bool,
                let walk = snapData["walk"] as? Bool {

                    print("SISPO: Returning 'place to visit' object")
                    
                    let place = Place(name: name, nameRu: nameRu, placeDesc: placeDesc, descRu: descRu, drink: drink, walk: walk, eat: eat, smoke: smoke, lat: lat, lon: lon, phone: phone, imgPaths: imgPaths)
                    
                    return place
                } else if let website = snapData["website"] as? String, let websiteURL = URL(string: website) {
                    
                    print("SISPO: Returning place with website object")
                    
                    let place = Place(name: name, nameRu: nameRu, placeDesc: placeDesc, descRu: descRu, lat: lat, lon: lon, phone: phone, imgPaths: imgPaths, website: websiteURL)
                    return place
                } else {
                    
                    print("SISPO: Returning basic place object")
                    
                    let place = Place(name: name, nameRu: nameRu, placeDesc: placeDesc, descRu: descRu, lat: lat, lon: lon, phone: phone, imgPaths: imgPaths)
                    return place
                }
                
                
            } else {
                print("SISPO: Error while downcasting geoLoc")
            }
        } else {
            print("SISPO: Error while downcasting place snapData")
        }

        
        return Place()
    }
    
    func getFoodObjectFrom(snap: Dictionary<String,AnyObject>) -> Food {
        if let name = snap["name"] as? String,
        let imgPath = snap["imgPath"] as? String,
        let menu = snap["menu"] as? String,
        let menuRu = snap["menuRu"] as? String,
        let website = snap["website"] as? String,
        let phones = snap["phones"] as? [String],
        let time = snap["time"] as? Dictionary<String, Int> {
            
            print("SISPO: Successfully downcated dict of type Food")
            if let open = time["open"],
                let close = time["close"] {
                print("SISPO: Successfully get open and close time")
                
                
                if let websiteUrl = URL(string: website) {
                    print("SISPO: Successfully created food website url")
                    
                    let food = Food(name: name, menu: menu, menuRu: menuRu, phones: phones, imgPath: imgPath, timeOpen: open, timeClose: close, website: websiteUrl)
                    return food
                }
            }
            
            
        }
        return Food()
    }
    
    func getPlaceArrayOf(type: String) -> [Place] {
        
        var filteredPlaces = [Place]()
        for place in placesArray {
            print("SISPO: Place obj 1011: \(place.name)")
            if let eat = place.eat {
                print("We have eat")
            }
        }
            switch type {
            case KEY_EAT:
                filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                    place.eat!
                })
            case KEY_WALK:
                filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                    place.walk!
                })

            case KEY_DRINK:
                filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                    place.drink!
                })
            case KEY_SMOKE:
                filteredPlaces = placesArray.filter({ (place:Place) -> Bool in
                    place.smoke!
                })
            case KEY_HOTELS:
                return hotelsArray
            case KEY_MALLS:
                return mallsArray
            default:
                print("SISPO: Error filtering places array")
            }
        
        return filteredPlaces
        
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
    
    func imageFor(path: String) -> UIImage? {
        let fullPath = documentsURLForFileName(name: path)
        do {
            let imgData = try Data(contentsOf: fullPath)
            let image = UIImage(data: imgData)
            print("SISPO: Successfully get image for path: \(path)")
            return image
        } catch {
            print("SISPO: Couldn't find image for path \(path)")
        }
        
        return nil
        
    }
    
    func documentsURLForFileName(name: String) -> URL {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(name)
        return fileURL
    }
    
// MARK: - Call service -
    
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
            UIApplication.shared.openURL(url)
        }
    }
    
// MARK: - GPS Service -
    
    func openMapForPlace(lat: Double, lon: Double, name: String) {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = lon
        
        let regionDistance: CLLocationDistance = 2000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(name)"
        mapItem.openInMaps(launchOptions: options)
        print("SISPO: Open map with lat: \(lat) and long: \(lon)")
    }
}

