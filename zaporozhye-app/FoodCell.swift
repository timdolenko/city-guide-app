//
//  FoodCell.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import FirebaseStorage

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    
    func configureCell(food: Food) {
        
        if food.isFoodServiceOpen() {
            bottomView.backgroundColor = UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0)
        } else {
            bottomView.backgroundColor = UIColor(red:0.82, green:0.01, blue:0.11, alpha:1.0)
        }
        
        timeLbl.text = "\(food.timeOpen):00 - \(food.timeClose):00"
        
        if let img = DataService.ds.imageFor(path: food.imgPath) {
            self.imgMain.image = img
        } else {
            let ref = FIRStorage.storage().reference().child(food.imgPath)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download image from Firebase storage: \(error)")
                } else {
                    print("Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.imgMain.image = img
                            DataService.ds.saveToLocalData(img: img, with: food.imgPath)
                        }
                    }
                }
            })
        }
    }
    
}
