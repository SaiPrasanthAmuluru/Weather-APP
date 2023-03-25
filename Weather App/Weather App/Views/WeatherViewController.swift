//
//  WeatherViewController.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationTextField : UITextField!
    @IBOutlet weak var locationTableView : UITableView!
    @IBOutlet weak var locationnameLabel : UILabel!
    @IBOutlet weak var weatherImageView : UIImageView!
    @IBOutlet weak var temparatureLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var dewPointLabel : UILabel!
    @IBOutlet weak var visibilityLabel : UILabel!
    
    var locationsArray : GeoCodeResponse?
    
    var weatherViewModel : WeatherViewModel{
        var weatherViewModel = WeatherViewModel()
        weatherViewModel.delegate = self
        return weatherViewModel
    }
    var geoViewModel : GeoCodeViewModel{
        var geoCodeViewModel = GeoCodeViewModel()
        geoCodeViewModel.delegate = self
        geoCodeViewModel.validationDelegate = self
        return geoCodeViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTableView.register(UITableViewCell.self,forCellReuseIdentifier: Identifiers.locationsTableIdentifier)
        locationTableView.delegate = self
        locationTableView.dataSource = self
    }
    
    /**
     IBAction Method to get locations based on the search Strign
     
     - parameter sender: UIButton
     */
    @IBAction func searchClicked(_ sender : UIButton){
        self.view.endEditing(true)
        geoViewModel.getWeatherLocations(geoCodeRequest: locationTextField.text ?? "")
    }
    
    /**
     Methis to get weather info for selected location
     
     - parameter locationInfo: location info to get lat and long from selected location
     */
    func getWeatherInfo(locationInfo : GeoCodeResponseModel){
        weatherViewModel.getWeather(weatherRequest: locationInfo)
    }
    
     /**
      Method to show alert when getWeatherinfo api throws error
      
      - parameter title:   response message from the get weather api
      - parameter message: any message can be empty
      */
     func showNoWeatherinfoAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.okAlertTitle, style: .default, handler: nil))
         alert.addAction(UIAlertAction(title: Constants.showStaticWeather, style: .default, handler: { action  in
             self.showStaticWeather(weatherInfo: self.weatherViewModel.getStaticWeatherData())
         }))
        self.present(alert, animated: true)
    }
    
    /**
     Methos to show static weather info when fetching fails due to subscription
     
     - parameter weatherInfo: WeatherInfo giving all data to show
     */
    func showStaticWeather(weatherInfo : WeatherModel){
        locationnameLabel.text = weatherInfo.timezone
        temparatureLabel.text = "Temp : \(weatherInfo.current.temp) F"
        dewPointLabel.text = "Dew Point : \(weatherInfo.current.dewPoint) F"
        humidityLabel.text = "Humidity : \(weatherInfo.current.humidity) %"
        visibilityLabel.text = "Visibility : \(weatherInfo.current.visibility / 1000) km"
        let newThread = DispatchQueue.global()
        newThread.async{ [weak self] in
            if let imageData = self?.weatherViewModel.getWeatherImage(iconStr: weatherInfo.current.weather[0].icon){
                DispatchQueue.main.async{
                    self?.weatherImageView.image = UIImage(data: imageData)
                }
                newThread.suspend()
            }else{
                newThread.suspend()
            }
        }
    }
}
