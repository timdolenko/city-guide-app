//
//  WeatherCell.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDayLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    
    var day: Day!
    
    func configureCell(_ day: Day, temp: String) {
        self.day = day
        
        
        day.getDayOfWeek()
        self.weekDayLbl.text = day.dayOfWeek
        if temp == "C" {
           self.tempLbl.text = day.tempC
        } else {
            self.tempLbl.text = day.tempF
        }
        
        switch day.weatherId {
        case "800":
            self.weatherImg.image = UIImage(named: "sun")
        case "300", "301", "302", "310", "311", "312", "313", "314", "321":
            self.weatherImg.image = UIImage(named: "cloud_rain")
        case "500", "501", "502", "503", "504", "511", "520", "521", "522", "531":
            self.weatherImg.image = UIImage(named: "rain_sun")
        case "802", "803", "804":
            self.weatherImg.image = UIImage(named: "cloud")
        case "801":
            self.weatherImg.image = UIImage(named: "cloud_sun")
        case "701", "711", "721", "731", "741", "751", "761", "762", "771", "781":
            self.weatherImg.image = UIImage(named: "cloud_sun_fog")
        case "600", "601", "602", "611", "612", "615", "616", "620", "621", "622":
            self.weatherImg.image = UIImage(named: "cloud_snow")
        default:
            self.weatherImg.image = UIImage(named: "cloud_download")
        }
    }

}
