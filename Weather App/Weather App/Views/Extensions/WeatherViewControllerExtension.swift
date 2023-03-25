//
//  WeatherViewControllerExtension.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation
import UIKit
extension WeatherViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.locationsTableIdentifier, for: indexPath)
        
        var detailConfiguration = locationCell.defaultContentConfiguration()

        if let locationsArray = locationsArray{
            let locationDetails = locationsArray[indexPath.row]
            detailConfiguration.text = "\(locationDetails.name) \(locationDetails.country)"
            detailConfiguration.textProperties.color = UIColor.white
        }
        locationCell.contentConfiguration = detailConfiguration
        locationCell.contentView.backgroundColor = .clear
        locationCell.backgroundColor = .clear
        return locationCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationTableView.isHidden = true
        if let locationsArray = locationsArray{
            let locationDetails = locationsArray[indexPath.row]
            getWeatherInfo(locationInfo: locationDetails)
        }
    }
}

extension WeatherViewController : WeatherDelegate{
    func getWeatherSuccessResponse(response: WeatherModel) {
        
    }
    
    func getWeatherErrorResponse(response: WeatherFailureModel) {
        self.showNoWeatherinfoAlert(title: response.message, message: "")
    }
}
extension WeatherViewController : GeoCodeDelegate{

    func getLocationsSuccess(response : [GeoCodeResponseModel]){
        if response.count > 0{
            locationsArray = response
            locationTableView.isHidden = false
            locationTableView.reloadData()
        }
    }
    
    func getLocationsFailure(){
        self.showAlert(title: "Unable to fetch Locations", message: "")
    }
}

extension WeatherViewController : ValidationDelegate{
    func validationFailed(errorMessage: String) {
        self.showAlert(title: errorMessage, message: "")
    }
}
