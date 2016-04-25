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
import Alamofire
import MBProgressHUD
import SwiftyJSON


class ViewController: UIViewController, OpenWeatherMapDelegate {
    
    var openWeather = openMapWeather()
    var hud = MBProgressHUD()

    
    @IBAction func cityTappedButton(sender: UIBarButtonItem) {
        displayCity()
    }
    @IBOutlet weak var weatherIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.openWeather.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayCity() {
        
        let alert = UIAlertController(title: "City", message: "Enter name city", preferredStyle: UIAlertControllerStyle.Alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            (action) -> Void in
            if let textFieled = (alert.textFields?.first)! as? UITextField {
                self.activity()
                self.openWeather.getWeatherForCity(textFieled.text!)
            }
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextFieldWithConfigurationHandler { (textFiled) -> Void in
            textFiled.placeholder = "Enter city name"
        }
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func activity() {
        hud.labelText = "Loading..."
        hud.dimBackground = true
        self.view.addSubview(hud)
        hud.show(true)
    }
    
    // MARK:  updateWeather
    
    func updateWeatherInfo(weatherJson : JSON ) {
        
        hud.hide(true)
        
        if let tempResalt = weatherJson["list"][0]["main"]["temp"].double {
            //Get country
            let country = weatherJson["city"]["coord"]["country"].stringValue
            //Get Convert temperature
            let temperature = openWeather.convertTemperature(country, temp: tempResalt)
            //Get city
            let cityName = weatherJson["city"]["name"].stringValue
            //Get icon 
            let weatherStringIcon = weatherJson["list"][0]["weather"][0]["icon"].stringValue
            let weatherIcon = openWeather.getWeatherIcon(weatherStringIcon)
        
            
            //print data
            print(cityName)
            print(temperature)
            self.weatherIcon.image = weatherIcon
            
            
        } else {
            print("Please enter correct info")
        }
        
    }
    
    func failConnect() {
        // NO connection internet
        let networkController = UIAlertController(title: "Error", message: "No connection!", preferredStyle: UIAlertControllerStyle.Alert)
        let buttonOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        networkController.addAction(buttonOK)
        self.presentViewController(networkController, animated: true, completion: nil)
        
    }
    
}

