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

        // Do any additional setup after loading the view.
    }
    //if something goes wrong with
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Try to replace any spaces in the search bar text with + signs. If you can't, stop running the function
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: "", with: "+") else {
            return
        }
        apiManager.geocode(address: searchAddress) {
            (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                //Use that data to make a dark sky call
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
}
