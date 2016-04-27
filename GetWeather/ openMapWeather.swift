//
//   openMapWeather.swift
//  GetWeather
//
//  Created by Александр Прендота on 16.04.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import CoreLocation

protocol OpenWeatherMapDelegate {
    
    func updateWeatherInfo(weatherJson : JSON)
    func failConnect()
    func updateLocation(weatherJson : JSON)
    
}

class openMapWeather {
    
    var apiKey = "a7a551a913b3979fe01b3e56c05d2a5f"
    
    var nameCity : String?
    var temperature : Double?
    var currentTime : String?
    var icon : UIImage?

    var delegate : OpenWeatherMapDelegate!
    
    func getWeatherForCity(city : String) {
        let weatherUrl = "http://api.openweathermap.org/data/2.5/forecast/city"
        let params = ["q" : city, "APPID" : apiKey]
        setAlamofire(params, apiURL: weatherUrl)
    }

    func setAlamofire(params: [String : AnyObject]?, apiURL : String) {
    
        request(.GET, apiURL, parameters: params).responseJSON {response in
            if(response.result.error != nil) {
                self.delegate.failConnect()
            } else {
                let weatherJSON = JSON(response.result.value!)
                let weatherJSONLoc = JSON(response.result.value!)
            
                // в общий поток
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate.updateWeatherInfo(weatherJSON)
                    self.delegate.updateLocation(weatherJSONLoc)
                })
            }
        }
    }
    
    func weatherFor(geo : CLLocationCoordinate2D) {
         //http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&APPID=a7a551a913b3979fe01b3e56c05d2a5f

        
        let geoURL = "http://api.openweathermap.org/data/2.5/weather?"
        let params = ["lat" : geo.latitude  , "lon" : geo.longitude, "APPID" : apiKey]
        
        setAlamofire(params as? [String : AnyObject], apiURL: geoURL)

    }
    

    func timeFromUnix(unixTime : Int) -> String {
    
        let timeInSecond = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSecond)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
    
        return dateFormatter.stringFromDate(weatherDate)
    }

    func getWeatherIcon(stringIcon: String) -> UIImage {
    
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

    func convertTemperature(country : String, temp : Double) -> Double {
        if country == "US" || country == "USA" {
            return round(((temp - 273.15)*1.8) + 32)
        } else {
            return round(temp - 273.15)
        }
    }

}
































