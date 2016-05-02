//
//  ViewController.swift
//  GetWeather
//
//  Created by Александр Прендота on 09.04.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import MBProgressHUD
import SwiftyJSON
import CoreLocation


class ViewController: UIViewController, OpenWeatherMapDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var speedWideLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    
    
    
    var timeText1: String!
    var timeText2: String!
    var timeText3: String!
    var timeText4: String!
    
    var tempText1: String!
    var tempText2: String!
    var tempText3: String!
    var tempText4: String!
    
    var iconImage1: UIImage!
    var iconImage2: UIImage!
    var iconImage3: UIImage!
    var iconImage4: UIImage!
    
    var openWeather = openMapWeather()
    var hud = MBProgressHUD()
    let locationManager : CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // backButton (forecastView)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        //Set Background
        
        let background = UIImage(named: "bg")
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        // Set setup
        self.openWeather.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cityButton(sender: UIBarButtonItem) {
        
        displayCity()
        
    }

    func displayCity() {
        
        let alert = UIAlertController(title: "City", message: "Enter name city", preferredStyle: UIAlertControllerStyle.Alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            if let textFieled = (alert.textFields?.first) {
                self.activity()
                self.openWeather.getWeatherForecast(textFieled.text!)
            }
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextFieldWithConfigurationHandler { (textFiled) -> Void in
            textFiled.placeholder = "Enter city name"
        }
        self.presentViewController(alert, animated: true, completion: nil)
        
        hud.hide(true)
        
    }
    
    func activity() {
        
        hud.labelText = "Loading..."
        hud.dimBackground = true
        self.view.addSubview(hud)
        hud.show(true)
    }
    
    // MARK:  updateWeather
    
    func updateWeatherInfoForecast(weatherJson : JSON ) {
        
        hud.hide(true)
        
        if let tempResalt = weatherJson["list"][0]["main"]["temp"].double {
            
            //Get country
            let country = weatherJson["city"]["country"].stringValue
            
            //Get city
            let cityName = weatherJson["city"]["name"].stringValue
            self.CityLabel.text = "\(cityName),\(country)"
            print(cityName)
            
            //Get Convert temperature
            let temperature = openWeather.convertTemperature(country, temp: tempResalt)
            self.tempLabel.text = "\(String(temperature))°"
            print(temperature)
            
            // Get humidity
            let humidity = weatherJson["list"][0]["main"]["humidity"].intValue
            self.humidityLabel.text = String(humidity)
            
            //Get speed wind
            let windSpeed = weatherJson["list"][0]["wind"]["speed"].intValue
            self.speedWideLabel.text = String(windSpeed)

            //Get description
            let description = weatherJson["list"][0]["weather"][0]["description"].stringValue
            self.descriptionLabel.text = description.uppercaseString
            
            //Get time

            let now = Int(NSDate().timeIntervalSince1970)
            //let time = weatherJson["dt"].intValue
            let timeToString = openWeather.timeFromUnix(now)
            self.timeLabel.text = "At \(timeToString) it is"
            
            //Get icon
            let weatherStringIcon = weatherJson["list"][0]["weather"][0]["icon"].stringValue
            let weatherIcon = openWeather.getWeatherIcon(weatherStringIcon)
            self.iconWeather.image = weatherIcon
            
            
            for i in 1...4 {
                if let tempResalt = weatherJson["list"][i]["main"]["temp"].double {
                    //Get temperature
                    let temperature = openWeather.convertTemperature(country, temp: tempResalt)
                
                    if i == 1 {
                        tempText1 = String(temperature)
                    } else if i == 2 {
                        tempText2 = String(temperature)
                    } else if i == 3 {
                        tempText3 = String(temperature)
                    } else if i == 4 {
                        tempText4 = String(temperature)
                    }
                    
                    //Get time 
                    let time = weatherJson["list"][i]["dt"].intValue
                    let timeToString = openWeather.timeFromUnix(time)
                    
                    if i == 1 {
                        timeText1 = String(timeToString)
                    } else if i == 2 {
                        timeText2 = String(timeToString)
                    } else if i == 3 {
                        timeText3 = String(timeToString)
                    } else if i == 4 {
                        timeText4 = String(timeToString)
                    }
                    
                    // Get image
                    let weatherStringIcon = weatherJson["list"][i]["weather"][0]["icon"].stringValue
                    let weatherIcon = openWeather.getWeatherIcon(weatherStringIcon)
                    
                    if i == 1 {
                        iconImage1 = weatherIcon
                    } else if i == 2 {
                        iconImage2 = weatherIcon
                    } else if i == 3 {
                        iconImage3 = weatherIcon
                    } else if i == 4 {
                        iconImage4 = weatherIcon
                    }

                }
            }
            
        } else {
            print("Some problem with gitting correct info")
        }
        
        
    }
    
    // MARK : CLLDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // print(manager.location!)
        self.activity()
        let correntLoc = locations.last! as CLLocation
        
        if (correntLoc.horizontalAccuracy > 0) {
            //stop - save bat energy
            locationManager.stopUpdatingLocation()
            
            let coordinates = CLLocationCoordinate2DMake(correntLoc.coordinate.latitude, correntLoc.coordinate.longitude)
            
            self.openWeather.weatherFor(coordinates)
           
            print(coordinates)
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        print("Cant get your location")
        self.displayCity()
        
    }
    
    func failConnect() {
        // NO connection internet
        let networkController = UIAlertController(title: "Error", message: "No connection!", preferredStyle: UIAlertControllerStyle.Alert)
        let buttonOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        networkController.addAction(buttonOK)
        self.presentViewController(networkController, animated: true, completion: nil)
        
    }
    
    // MARK : Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "moreInfo" {
            let forecastController = segue.destinationViewController as? ViewControllerForecast
            
            forecastController?.time1 = self.timeText1
            forecastController?.time2 = self.timeText2
            forecastController?.time3 = self.timeText3
            forecastController?.time4 = self.timeText4
            
            forecastController?.temp1 = self.tempText1
            forecastController?.temp2 = self.tempText2
            forecastController?.temp3 = self.tempText3
            forecastController?.temp4 = self.tempText4
            
            forecastController?.icon1 = self.iconImage1
            forecastController?.icon2 = self.iconImage2
            forecastController?.icon3 = self.iconImage3
            forecastController?.icon4 = self.iconImage4
            
        }
    }
    
}
