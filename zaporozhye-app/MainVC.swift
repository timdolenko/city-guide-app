//
//  MainVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/4/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    let tapRec = UITapGestureRecognizer()

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var weatherBtn: UIImageView!
    
    override func viewDidLoad() {
        moreBtn.layer.cornerRadius = 4.0
        
        tapRec.addTarget(self, action: #selector(MainVC.weatherBtnTapped))
        weatherBtn.addGestureRecognizer(tapRec)
        
        WeatherService.instance.loadForecast()
        DataService.ds.getDataFromFirebase()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.onForecastLoaded(_:)), name: NSNotification.Name("forecastLoaded") as NSNotification.Name, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if WeatherService.instance.loadedForecast.count > 0 {
            updateImg()
        }
    }
    
    func weatherBtnTapped() {
        performSegue(withIdentifier: SEGUE_WEATHERVC_FROM_MAIN, sender: nil)
    }
    
    func onForecastLoaded(_ notif: AnyObject) {
        updateImg()
    }

    func updateImg() {
        self.weatherBtn.image = UIImage(named: "\(WeatherService.instance.getMainImagePath(WeatherService.instance.loadedForecast[0].weatherId))")
    }

    
}

