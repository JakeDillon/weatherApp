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
  
        
        
        // When the screen first loads, set the default values for the UI
        setupDefaultUI()
        
        
        
        let darkSkyURL = "https://api.darksky.net/forecast/"
        let apiKeys = APIKeys()
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyURL + darkSkyKey + "/" + latitude + "," + longitude
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentcuky" + "&key=" + apiKeys.googleKey
        let googleRequest = Alamofire.request(googleRequestURL)
        
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
            let json = JSON(value)
            print(json)
            case .failure(let error):
                print(error.localizedDescription)
            
        }
    
        }
    }
        // This function will give the UI some default whenever we first we first load the app
        func setupDefaultUI() {
            locationLabel.text = ""
            iconLabel.text = ""
            currentTempLabel.text = "Enter a location"
            highTempLabel.text = "-"
            lowTempLabel.text = "-"
        }
        
        
    
    


}

