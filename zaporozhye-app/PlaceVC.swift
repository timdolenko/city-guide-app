//
//  PlaceVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/27/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class PlaceVC: ProjectVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var reservationLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var websiteBtnView: RoundedView!
    @IBOutlet weak var websiteBtn: UIButton!
    @IBOutlet weak var reservationBtn: UIButton!
    @IBOutlet weak var reservationView: RoundedView!
    var place = Place()
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SISPO: GeoLoc Long: \(place.geoLocLon), GeoLocLat \(place.geoLocLat)")
        print("SISPO: Selected place has \(place.imgPaths.count) image paths")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        titleLbl.text = place.name
        descLbl.text = place.placeDescription
        if place.phone == "" {
            reservationBtn.isHidden = true
            reservationView.isHidden = true
            phoneLbl.isHidden = true
        } else {
            phoneLbl.text = place.phone
        }
        
        if type == KEY_MALLS {
            if NSLocale.preferredLanguages[0] == "ru" {
                reservationLbl.text = "Информация"
            } else {
                reservationLbl.text = "Information"
            }
        }
        
        if place.website == nil {
            websiteBtn.isHidden = true
            websiteBtnView.isHidden = true
        } else {
            phoneLbl.isHidden = true
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.size.width
        print("SISPO: View width is: \(viewWidth), collection view width: \(collectionView.frame.width) and height: \(collectionView.frame.height)")
        let size = CGSize(width: viewWidth, height: viewWidth)
        print("SISPO: Cell size is \(size)")
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return place.imgPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceImageCell", for: indexPath) as? PlaceImageCell {
            cell.configureCell(imgPath: place.imgPaths[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }

    @IBAction func websiteBtnPressed(_ sender: AnyObject) {
    }
    
    @IBAction func reservationBtnPressed(_ sender: AnyObject) {
        if place.phone != nil && place.phone != "" {
            DataService.ds.call(phone: place.phone!)
        } else {
            let alertViewIcon = UIImage(named: "phone")
            SCLAlertView().showError("Sorry", subTitle: "This place has not pnone number to call.", closeButtonTitle: "Close", duration: 3.0, colorStyle: 0xFF0049, circleIconImage: alertViewIcon)
        }
        
    }
    
    @IBAction func showOnMapPressed(_ sender: AnyObject) {
        DataService.ds.openMapForPlace(lat: place.geoLocLat, lon: place.geoLocLon, name: place.name)
    }
    
}
