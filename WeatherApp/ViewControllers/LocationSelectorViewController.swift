//
//  LocationSelectorViewController.swift
//  WeatherApp
//
//  Created by Jake Dillon on 10/26/18.
//  Copyright © 2018 Jake Dillon. All rights reserved.
//

import UIKit

class LocationSelectorViewController: UIViewController,UISearchBarDelegate {

    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    
    // Instance of the API manager class so we can make API calls on this screen
    let apiManager = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    //if something goes wrong with
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Try to replace any spaces in the search bar text with + signs. If you can't, stop running the function
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: longitude) { (weatherData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let receivedData = weatherData {
                self.weatherData = receivedData
                self.performSegue(withIdentifier: "unwindToMainDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    func retrieveGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) { (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recivedData = geocodingData {
                self.geocodingData = recivedData
                self.retrieveWeatherData(latitude: recivedData.latitude, longitude: recivedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplayViewController, let retreivedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
            destinationVC.displayGeocodingData = retreivedGeocodingData
            destinationVC.displayWeatherData = retrievedWeatherData
        }
    }
}

