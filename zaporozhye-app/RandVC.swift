//
//  QuestVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 9/4/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import SCLAlertView
import FirebaseStorage

class RandVC: ProjectVC {

    @IBOutlet weak var typeBar: UIView!
    @IBOutlet weak var eatTypeImg: UIImageView!
    @IBOutlet weak var drinkTypeImg: UIImageView!
    @IBOutlet weak var smokeTypeImg: UIImageView!
    @IBOutlet weak var walkTypeImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    var placesArray = [Place]()
    var randomPlace = Place()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesArray = DataService.ds.placesArray
        randomPlace = DataService.ds.placesArray[0]
        setRandomPlace()
    }
    
    func setRandomPlace() {
        randomPlace = getRandomPlace()
        updateUI()
    }
    
    func getRandomPlace() -> Place {
        let num = arc4random_uniform(UInt32(placesArray.count))
        let randPlace = placesArray[Int(num)]
        print("SISPO: Random place is: \(randPlace.name)")
        return randPlace
    }
    
    func updateUI() {
        descLbl.text = randomPlace.placeDescription
        nameLbl.text = randomPlace.name
        
        let path = randomPlace.imgPaths[0]
        if let img = DataService.ds.imageFor(path: path) {
            self.mainImage.image = img
        } else {
            let ref = FIRStorage.storage().reference().child(path)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download image from Firebase storage: \(error)")
                } else {
                    print("Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.mainImage.image = img
                            DataService.ds.saveToLocalData(img: img, with: path)
                        }
                    }
                }
            })
        }
        
        if randomPlace.drink! {
            drinkTypeImg.isHidden = false
        } else {
            drinkTypeImg.isHidden = true
        }
        if randomPlace.eat! {
            eatTypeImg.isHidden = false
        } else {
            eatTypeImg.isHidden = true
        }
        if randomPlace.smoke! {
            smokeTypeImg.isHidden = false
        } else {
            smokeTypeImg.isHidden = true
        }
        if randomPlace.walk! {
            walkTypeImg.isHidden = false
        } else {
            walkTypeImg.isHidden = true
        }
        
    }
    
    @IBAction func refreshBtnPressed(_ sender: AnyObject) {
        setRandomPlace()
    }
    @IBAction func phoneBtnPressed(_ sender: AnyObject) {
        if randomPlace.phone != nil && randomPlace.phone != "" {
            DataService.ds.call(phone: randomPlace.phone!)
        } else {
            let alertViewIcon = UIImage(named: "phone")
            SCLAlertView().showError("Sorry", subTitle: "This place has not pnone number to call.", closeButtonTitle: "Close", duration: 3.0, colorStyle: 0xFF0049, circleIconImage: alertViewIcon)
        }
    }
    @IBAction func showOnMapBtnPressed(_ sender: AnyObject) {
        DataService.ds.openMapForPlace(lat: randomPlace.geoLocLat, lon: randomPlace.geoLocLon, name: randomPlace.name)
    }

}
