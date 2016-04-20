//
//   openMapWeather.swift
//  GetWeather
//
//  Created by Александр Прендота on 16.04.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import Foundation


class openMapWeather {
    var name : String
    var description : String
    //var temp : Int
    
    init(weatherJSON : NSDictionary) {
        
        let city =  weatherJSON["city"] as! NSDictionary
        name = city["name"] as! String

        let weather = weatherJSON["list"]![0]!["weather"]!![0] as! NSDictionary
        description = weather["description"] as! String

       
       
        
    }
}