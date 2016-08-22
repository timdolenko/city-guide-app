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
        super.viewDidLoad()
        moreBtn.layer.cornerRadius = 4.0
        
        tapRec.addTarget(self, action: #selector(MainVC.weatherBtnTapped))
        weatherBtn.addGestureRecognizer(tapRec)
        
        WeatherForecast.instance.loadForecast()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.onForecastLoaded(_:)), name: NSNotification.Name("forecastLoaded") as NSNotification.Name, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if WeatherForecast.instance.loadedForecast.count > 0 {
            updateImg()
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func weatherBtnTapped() {
        performSegue(withIdentifier: "WeatherVC", sender: nil)
    }
    
    func onForecastLoaded(_ notif: AnyObject) {
        updateImg()
    }

    func updateImg() {
        self.weatherBtn.image = UIImage(named: "\(WeatherForecast.instance.getMainImagePath(WeatherForecast.instance.loadedForecast[0].weatherId))")
    }

    
}

