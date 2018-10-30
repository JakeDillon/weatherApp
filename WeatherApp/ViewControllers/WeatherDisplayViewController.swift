//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jake Dillon on 10/25/18.
//  Copyright © 2018 Jake Dillon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            //When the screen first loads, set the default values for the UI
            setupDefaultUI()
            
            let apiManager = APIManager()
            
            apiManager.geocode(address: "Glasgow,+Kentucky") { (data, error) in
                //If we get back an error
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                print(data.formattedAddress)
                print(data.latitude)
                print(data.longitude)
            }
            
            apiManager.getWeather(latitude: 37.004842, longitude: -85.925876) { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                print(data.temperature)
                print(data.highTemperature)
                print(data.lowTemperature)
                print(data.condition.icon)
            }
        }
        
        //This function will give the UI some default values whenever we first load the app
        func setupDefaultUI() {
            locationLabel.text = ""
            iconLabel.text = "☂️"
            currentTempLabel.text = "Enter a location!"
            highTempLabel.text = "-"
            lowTempLabel.text = "-"
        }
}

