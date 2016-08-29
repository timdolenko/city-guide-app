//
//  PlaceVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/27/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class PlaceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var reservationBtn: UIButton!
    @IBOutlet weak var reservationView: RoundedView!
    var place = Place()
    
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
        }
        phoneLbl.text = place.phone
        
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
    
    func openMapForPlace(lat: Double, lon: Double) {
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
        mapItem.name = "\(place.name)"
        mapItem.openInMaps(launchOptions: options)
        print("SISPO: Open map with lat: \(lat) and long: \(lon)")
    }

    @IBAction func reservationBtnPressed(_ sender: AnyObject) {
        DataService.ds.call(phone: place.phone)
    }
    
    @IBAction func showOnMapPressed(_ sender: AnyObject) {
        openMapForPlace(lat: place.geoLocLat, lon: place.geoLocLon)
    }
    

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
