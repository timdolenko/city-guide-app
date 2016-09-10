//
//  OrderFoodVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/30/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import SCLAlertView

class OrderFoodVC: ProjectVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var hideBtn: UIButton!
    
    var foodArray = [Food]()
    var infoViewIsHidden: Bool = true
    var selectedFood = Food()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodArray = DataService.ds.foodArray
        selectedFood = foodArray[0]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var infoFrame = self.informationView.frame
        
        let infoFrameHeight = infoFrame.size.height + 24
        
        infoFrame.origin.y += infoFrameHeight
        var btnFrame = self.hideBtn.frame
        btnFrame.origin.y += infoFrameHeight
        self.informationView.frame = infoFrame
        self.hideBtn.frame = btnFrame
        self.informationView.isHidden = false
        self.hideBtn.isHidden = false
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFood = foodArray[indexPath.row]
        menuLbl.text = selectedFood.menu
        nameLbl.text = selectedFood.name
        if infoViewIsHidden {
            infoViewIsHidden = false
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                
                var btnFrame = self.hideBtn.frame
                var infoFrame = self.informationView.frame
                
                let infoFrameHeight = infoFrame.size.height + 24
                
                infoFrame.origin.y -= infoFrameHeight
                btnFrame.origin.y -= infoFrameHeight
                
                self.informationView.frame = infoFrame
                self.hideBtn.frame = btnFrame
                
            }) { finished in
                print("SISPO: Finished animating")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        let height = width / 1.15584416
        let size = CGSize.init(width: width, height: height)
        return size
    }

    @IBAction func downBtnPressed(_ sender: AnyObject) {
        self.infoViewIsHidden = true
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            
            var btnFrame = self.hideBtn.frame
            var infoFrame = self.informationView.frame
            
            let infoFrameHeight = infoFrame.size.height + 24
            
            infoFrame.origin.y += infoFrameHeight
            btnFrame.origin.y += infoFrameHeight
            
            self.informationView.frame = infoFrame
            self.hideBtn.frame = btnFrame
            
        }) { finished in
            print("SISPO: Finished animating")
        }
    }
    
    
    @IBAction func websiteBtnPressed(_ sender: AnyObject) {
        if !self.infoViewIsHidden {
            UIApplication.shared.openURL(selectedFood.website)
        }
    }
    
    @IBAction func orderBtnPressed(_ sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "AvenirNextCondensed-Regular", size: 20)!,
            kTextFont: UIFont(name: "AvenirNextCondensed-Regular", size: 14)!,
            kButtonFont: UIFont(name: "AvenirNextCondensed-DemiBold", size: 14)!
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        for phone in selectedFood.phones {
            alertView.addButton(phone, action: {
                DataService.ds.call(phone: phone)
            })
        }
        
        let alertViewIcon = UIImage(named: "phone")
        
        alertView.showSuccess("Please", subTitle: "Select a phone", colorStyle: 0x38A9FE, circleIconImage: alertViewIcon, animationStyle: .bottomToTop)
        
        
    }

}
