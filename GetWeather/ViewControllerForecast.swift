//
//  ViewControllerForecast.swift
//  GetWeather
//
//  Created by Александр Прендота on 01.05.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import UIKit

class ViewControllerForecast: UIViewController {


    @IBOutlet weak var tempForecast1: UILabel!
    @IBOutlet weak var tempForecast4: UILabel!
    @IBOutlet weak var tempForecast3: UILabel!
    @IBOutlet weak var tempForecast2: UILabel!
    

    @IBOutlet weak var timeForecast1: UILabel!
    @IBOutlet weak var timeForecast4: UILabel!
    @IBOutlet weak var timeForecast3: UILabel!
    @IBOutlet weak var timeForecast2: UILabel!
    

    @IBOutlet weak var iconForecast1: UIImageView!
    @IBOutlet weak var iconForecast4: UIImageView!
    @IBOutlet weak var iconForecast3: UIImageView!
    @IBOutlet weak var iconForecast2: UIImageView!
    
    
    var time1: String!
    var time2: String!
    var time3: String!
    var time4: String!
    
    var temp1: String!
    var temp2: String!
    var temp3: String!
    var temp4: String!
    
    var icon1: UIImage!
    var icon2: UIImage!
    var icon3: UIImage!
    var icon4: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImage(named: "bg1.jpg")
        self.view.backgroundColor = UIColor(patternImage: background!)
//        
//        self.viewForecast.layer.cornerRadius = self.viewForecast.frame.size.width/2
//        self.viewForecast.clipsToBounds = true
//        
        tempForecast1.text = temp1
        tempForecast2.text = temp2
        tempForecast3.text = temp3
        tempForecast4.text = temp4
        
        timeForecast1.text = time1
        timeForecast2.text = time2
        timeForecast3.text = time3
        timeForecast4.text = time4
        
        iconForecast1.image = icon1
        iconForecast2.image = icon2
        iconForecast3.image = icon3
        iconForecast4.image = icon4
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
