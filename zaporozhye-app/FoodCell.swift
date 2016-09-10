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
            bottomView.backgroundColor = GREEN_COLOR
        } else {
            bottomView.backgroundColor = RED_COLOR
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
