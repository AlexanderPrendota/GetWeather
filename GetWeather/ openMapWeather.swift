//
//   openMapWeather.swift
//  GetWeather
//
//  Created by Александр Прендота on 16.04.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import Foundation
import UIKit


class openMapWeather {
    var name : String
    var description : String
    var temp : Int
    var wind : Int
    var currentTime : String?
    var icon : UIImage?
    
    init(weatherJSON : NSDictionary) {
        

        name = weatherJSON["city"]!["name"] as! String
        description = weatherJSON["list"]![0]!["weather"]!![0]["description"] as! String
        temp = weatherJSON["list"]![0]!["main"]!!["temp"] as! Int - 273
        wind = weatherJSON["list"]![0]!["wind"]!!["speed"] as! Int
        currentTime = timeFromUnix(weatherJSON["list"]![0]!["dt"] as! Int)
        icon = weatherIcon(weatherJSON["list"]![0]!["weather"]!![0]["icon"] as! String)
        
    }
}

func timeFromUnix(unixTime : Int) -> String {
    
    let timeInSecond = NSTimeInterval(unixTime)
    let weatherDate = NSDate(timeIntervalSince1970: timeInSecond)
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.stringFromDate(weatherDate)
}

func weatherIcon(stringIcon: String) -> UIImage {
    
    let imageName : String
    
    switch stringIcon {
        
        case "01d" : imageName = "01d"
        case "02d" : imageName = "02d"
        case "03d" : imageName = "03d"
        case "04d" : imageName = "04d"
        case "09d" : imageName = "09d"
        case "10d" : imageName = "10d"
        case "11d" : imageName = "11d"
        case "13d" : imageName = "13d"
        case "50d" : imageName = "50d"
        
        case "01n" : imageName = "01n"
        case "02n" : imageName = "02n"
        case "03n" : imageName = "03n"
        case "04n" : imageName = "04n"
        case "09n" : imageName = "09n"
        case "10n" : imageName = "10n"
        case "11n" : imageName = "11n"
        case "13n" : imageName = "13n"
        case "50n" : imageName = "50n"
        
    default: imageName = "none"
    }
    
    let imageIcon = UIImage(named: imageName)
    return imageIcon!

    
}












































