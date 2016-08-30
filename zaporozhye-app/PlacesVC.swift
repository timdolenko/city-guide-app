//
//  EatVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/24/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class PlacesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLlb: UILabel!
    
    var placesArray = [Place]()
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLlb.text = type
        placesArray = DataService.ds.getArrayOf(type: type)
        collectionView.reloadData()

        collectionView.delegate = self
        collectionView.dataSource = self
        print("SISPO: placesArray has \(placesArray.count) elements")
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as? PlaceCell {
            cell.configureCell(place: placesArray[indexPath.row])
            return cell
        }
        return PlaceCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        let height = width * 1.31012658
        let size = CGSize.init(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = placesArray[indexPath.row]
        performSegue(withIdentifier: SEGUE_PLACEVC, sender: selectedPlace)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_PLACEVC {
            if let placeVC = segue.destination as? PlaceVC {
                if let place = sender as? Place {
                    placeVC.place = place
                }
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}
