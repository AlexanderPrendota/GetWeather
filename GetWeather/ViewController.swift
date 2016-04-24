//
//  ViewController.swift
//  GetWeather
//
//  Created by Александр Прендота on 09.04.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, OpenWeatherMapDelegate {
    
    var openWeather = openMapWeather()
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
    
    // MARK:  Delegate
    
    func updateWeatherInfo() {
        print(openWeather.nameCity!)
    }
}

