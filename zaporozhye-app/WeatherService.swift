//
//  WeatherForecast.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/23/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class WeatherService {
    static let instance = WeatherService()
    
    let today = Date()
    
    private var _loadedForecast = [Day]()
    
    var loadedForecast: [Day] {
        return _loadedForecast
    }
    
    func downloadForecast() {
        
        deleteOutdatedForecast()
        
        let address = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=47.83&lon=35.16&cnt=7 &APPID=d970a32a11bfc0d8f84b908a83f9a517"
        let url = address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                print(dict)
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] , list.count == 7 {
                    
                    for x in 0...6 {
                        let day = list[x]
                        
                        let dayX: Day
                        
                        if let date = day["dt"] as? Double {
                            
                            
                            dayX = Day(date: date)
                            print("Date: \(dayX.date)")
                            
                            if let windSpeed = day["speed"] as? Double {
                                dayX.windSpeed = "\(windSpeed) m/s"
                                print("Wind Speed: \(dayX.windSpeed)")
                            } else {
                                dayX.windSpeed = ""
                            }
                            
                            if let windDirect = day["deg"] as? Int {
                                dayX.windDirect = windDirect
                                print("Wind Direct:\(dayX.windDirect)")
                            } else {
                                dayX.windDirect = 0
                            }
                            
                            if let clouds = day["clouds"] as? Int {
                                dayX.clouds = "\(clouds)"
                                print("Clouds:\(dayX.clouds)")
                            } else {
                                dayX.clouds = ""
                            }
                            
                            if let rain = day["rain"] as? Double {
                                dayX.rainVolume = "\(rain) mm"
                                print("Rain: \(dayX.rainVolume)")
                            } else {
                                dayX.rainVolume = "0 mm"
                            }
                            if let temp = day["temp"] as? Dictionary<String, Double> {
                                dayX.temp = temp["day"]
                                dayX.tempC = "\(Int(round(dayX.temp - 273.15))) °C"
                                dayX.tempF = "\(Int(round(dayX.temp * 9 / 5) - 459.67)) °F"
                                print("Temperature:\(dayX.temp)")
                                print("Temperature:\(dayX.tempC)")
                                print("Temperature:\(dayX.tempF)")
                            } else {
                                dayX.temp = 0
                                dayX.tempF = ""
                                dayX.tempC = ""
                            }
                            if let weather = day["weather"] as? [Dictionary<String, AnyObject>] {
                                if let weatherId = weather[0]["id"] as? Int {
                                    dayX.weatherId = "\(weatherId)"
                                    print("Weather ID:\(dayX.weatherId)")
                                } else {
                                    dayX.weatherId = ""
                                }
                                if let weatherMain = weather[0]["main"] as? String {
                                    dayX.weatherMain = weatherMain
                                    print("Weather Main:\(dayX.weatherMain)")
                                } else {
                                    dayX.weatherId = ""
                                }
                                if let weatherDesc = weather[0]["description"] as? String {
                                    dayX.weatherDesc = weatherDesc
                                    print("Weather Main:\(dayX.weatherDesc)")
                                } else {
                                    dayX.weatherId = ""
                                }
                                
                            }
                            self._loadedForecast.append(dayX)
                            if self._loadedForecast.count == 7 {
                                self.saveForecast()
                                NotificationCenter.default.post(NSNotification(name: "forecastLoaded" as NSNotification.Name, object: nil) as Notification)
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    func saveForecast() {
        let forecastData = NSKeyedArchiver.archivedData(withRootObject: _loadedForecast)
        UserDefaults.standard.set(forecastData, forKey: KEY_FORECAST)
        UserDefaults.standard.synchronize()
    }
    
    func loadForecast() {
        if let forecastData = UserDefaults.standard.object(forKey: KEY_FORECAST) as? Data {
            
            if let forecastArray = NSKeyedUnarchiver.unarchiveObject(with: forecastData) as? [Day] {
                _loadedForecast = forecastArray
            }
        }
        
        if loadedForecast.count == 0 {
            WeatherService.instance.downloadForecast()
        } else {
            checkForecast()
        }
        
        NotificationCenter.default.post(Notification(name: NSNotification.Name("forecastLoaded"), object: nil))
    }
    
    func checkForecast() {
        
        let downloadDate = loadedForecast[0].date
        
        let order = Calendar.current.compare(self.today, to: downloadDate!,
                                                             toUnitGranularity: .day)
        switch order {
        case .orderedDescending, .orderedAscending:
            downloadForecast()
        case .orderedSame:
            print("The forecast is up to date")
        }
        
    }
    
    func deleteOutdatedForecast() {
        _loadedForecast = []
        if (UserDefaults.standard.object(forKey: KEY_FORECAST) as? Data) != nil {
            
            UserDefaults.standard.removeObject(forKey: KEY_FORECAST)
            UserDefaults.standard.synchronize()
            
        }
    }
    
    func getMainImagePath(_ weatherId: String) -> String {
        switch weatherId {
        case "800":
            return "sun"
        case "300", "301", "302", "310", "311", "312", "313", "314", "321":
            return "cloud_rain"
        case "500", "501", "502", "503", "504", "511", "520", "521", "522", "531":
            return "rain_sun"
        case "802", "803", "804":
            return "cloud"
        case "801":
            return "cloud_sun"
        case "701", "711", "721", "731", "741", "751", "761", "762", "771", "781":
            return "cloud_sun_fog"
        case "600", "601", "602", "611", "612", "615", "616", "620", "621", "622":
            return "cloud_snow"
        default:
            return "cloud_download"
        }

    }
    
    func getWindImagePath(_ windDirect: Int) -> String {
        switch windDirect {
        case 0...20, 340...360:
            return "wind_N"
        case 21...60:
            return "wind_NE"
        case 61...120:
            return "wind_E"
        case 121...160:
            return "wind_SE"
        case 161...210:
            return "wind_S"
        case 211...250:
            return "wind_SW"
        case 251...290:
            return "wind_W"
        case 291...339:
            return "wind_NW"
        default:
            return "cloud_download"
        }
    }
    
}
