//
//  PlaceImageCell.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/27/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import Firebase

class PlaceImageCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func configureCell(imgPath: String) {
        if let img = DataService.ds.imageForPath(path: imgPath) {
            self.image.image = img
        } else {
            let ref = FIRStorage.storage().reference().child(imgPath)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("SISPO: Unable to download image from Firebase storage: \(error?.debugDescription)")
                } else {
                    print("SISPO: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.image.image = img
                            DataService.ds.saveToLocalData(img: img, with: imgPath)
                        }
                    }
                }
            })
        }

    }
}
