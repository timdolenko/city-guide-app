//
//  OrderFoodVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class OrderFoodVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var menuLbl: UILabel!
    
    var foodArray = [Food]()
    var infoViewIsHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodArray = DataService.ds.foodArray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var infoFrame = self.informationView.frame
        infoFrame.origin.y += infoFrame.size.height + 24
        self.informationView.frame = infoFrame
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as? FoodCell {
            cell.configureCell(food: foodArray[indexPath.row])
            return cell
        }
        return FoodCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        let height = width / 1.15584416
        let size = CGSize.init(width: width, height: height)
        return size
    }

    @IBAction func downBtnPressed(_ sender: AnyObject) {
        self.infoViewIsHidden = true
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
            
            var infoFrame = self.informationView.frame
            infoFrame.origin.y += infoFrame.size.height + 24
            
            self.informationView.frame = infoFrame
            
        }) { finished in
            print("Finished")
        }
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        if infoViewIsHidden {
            infoViewIsHidden = false
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseOut, animations: {
            
            var infoFrame = self.informationView.frame
            infoFrame.origin.y -= infoFrame.size.height + 24
            
            self.informationView.frame = infoFrame
            
        }) { finished in
            print("Finished")
        }
        }
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func websiteBtnPressed(_ sender: AnyObject) {
    }
    
    @IBAction func orderBtnPressed(_ sender: AnyObject) {
    }

}
