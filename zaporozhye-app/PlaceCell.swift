//
//  PlaceCell.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/24/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PlaceCell: UICollectionViewCell {
    
    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeLbl: UILabel!
    
    
    func configureCell(place: Place) {
        placeLbl.text = place.name
        
        if let img = DataService.ds.imageFor(path: place.imgPaths[0]) {
            self.placeImg.image = img
        } else {
            let ref = FIRStorage.storage().reference().child(place.imgPaths[0])
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download image from Firebase storage: \(error)")
                } else {
                    print("Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.placeImg.image = img
                            DataService.ds.saveToLocalData(img: img, with: place.imgPaths[0])
                        }
                    }
                }
            })
        }
    }
    
}
