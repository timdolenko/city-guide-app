//
//  WeatherVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class WeatherVC: ProjectVC, UICollectionViewDelegate, UICollectionViewDataSource {

    var tempType = "C"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainWeatherImg: UIImageView!
    @IBOutlet weak var mainWeatherLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var windDirectImg: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var rainVolumeLbl: UILabel!
    
    var selectedDay = Day()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(WeatherVC.refresh), name: Notification.Name("forecastLoaded"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if WeatherService.instance.loadedForecast.count > 0 {
            showWeather(0)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherService.instance.loadedForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            if WeatherService.instance.loadedForecast.count > 0 {
                let day = WeatherService.instance.loadedForecast[(indexPath as NSIndexPath).row]
                cell.configureCell(day, temp: tempType)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showWeather((indexPath as NSIndexPath).row)
    }

    @IBAction func tempChangeBtnPressed(_ sender: AnyObject) {
        if tempType == "C" {
            tempType = "F"
            tempLbl.text = selectedDay.tempF
            collectionView.reloadData()
        } else {
            tempType = "C"
            tempLbl.text = selectedDay.tempC
            collectionView.reloadData()
        }
    }
    
    @IBAction func refreshBtnPressed(_ sender: AnyObject) {
        reloadWeather()
    }
    
    func reloadWeather() {
        WeatherService.instance.downloadForecast()
    }
    
    func refresh() {
        collectionView.reloadData()
        
    }
    
    func showWeather(_ num: Int) {
        selectedDay = WeatherService.instance.loadedForecast[num]
        mainWeatherImg.image = UIImage(named: "\(WeatherService.instance.getMainImagePath(selectedDay.weatherId))")
        mainWeatherLbl.text = selectedDay.weatherDesc.capitalized
        windSpeedLbl.text = selectedDay.windSpeed
        if tempType == "C" {
            tempLbl.text = selectedDay.tempC
        } else {
            tempLbl.text = selectedDay.tempF
        }
        rainVolumeLbl.text = selectedDay.rainVolume
        windDirectImg.image = UIImage(named: "\(WeatherService.instance.getWindImagePath(selectedDay.windDirect))")
        
    }
    
}
