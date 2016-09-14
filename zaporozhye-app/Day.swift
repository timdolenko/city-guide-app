//
//  Day.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 7/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import Foundation

class Day: NSObject, NSCoding {
    
    var date: Date!
    var dayOfWeek: String!
    var temp: Double!
    var tempC: String!
    var tempF: String!
    var weatherId: String!
    var weatherMain: String!
    var weatherDesc: String!
    var windSpeed: String!
    var windDirect: Int!
    var rainVolume: String!
    var clouds: String!
    
    init(date: Double) {
        self.date = Date(timeIntervalSince1970: date)
    }
    
    func getDayOfWeek() {
        if let day = self.date {
            let weekDayString: String
            let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let weekDay = myCalendar.component(.weekday, from: day)
        
                switch weekDay{
                case 1:
                    weekDayString = "WEATHER_KEY_SU".localized
                case 2:
                    weekDayString = "WEATHER_KEY_MO".localized
                case 3:
                    weekDayString = "WEATHER_KEY_TU".localized
                case 4:
                    weekDayString = "WEATHER_KEY_WE".localized
                case 5:
                    weekDayString = "WEATHER_KEY_TH".localized
                case 6:
                    weekDayString = "WEATHER_KEY_FR".localized
                case 7:
                    weekDayString = "WEATHER_KEY_SA".localized
                default:
                    weekDayString = "Er"
                }
                self.dayOfWeek = weekDayString
        }
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.date = aDecoder.decodeObject(forKey: "day") as? Date
        self.temp = aDecoder.decodeObject(forKey: "temp") as? Double
        self.tempC = aDecoder.decodeObject(forKey: "tempC") as? String
        self.tempF = aDecoder.decodeObject(forKey: "tempF") as? String
        self.weatherId = aDecoder.decodeObject(forKey: "weatherId") as? String
        self.weatherMain = aDecoder.decodeObject(forKey: "weatherMain") as? String
        self.weatherDesc = aDecoder.decodeObject(forKey: "weatherDesc") as? String
        self.windSpeed = aDecoder.decodeObject(forKey: "windSpeed") as? String
        self.windDirect = aDecoder.decodeObject(forKey: "windDirect") as? Int
        self.rainVolume = aDecoder.decodeObject(forKey: "rainVolume") as? String
        self.clouds = aDecoder.decodeObject(forKey: "clouds") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.date, forKey: "day")
        aCoder.encode(self.temp, forKey: "temp")
        aCoder.encode(self.tempC, forKey: "tempC")
        aCoder.encode(self.tempF, forKey: "tempF")
        aCoder.encode(self.weatherId, forKey: "weatherId")
        aCoder.encode(self.weatherMain, forKey: "weatherMain")
        aCoder.encode(self.weatherDesc, forKey: "weatherDesc")
        aCoder.encode(self.windSpeed, forKey: "windSpeed")
        aCoder.encode(self.windDirect, forKey: "windDirect")
        aCoder.encode(self.rainVolume, forKey: "rainVolume")
        aCoder.encode(self.clouds, forKey: "clouds")
    }
    
}
