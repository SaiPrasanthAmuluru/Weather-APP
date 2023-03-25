//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation

protocol WeatherDelegate : AnyObject{
    func getWeatherSuccessResponse(response : WeatherModel)
    func getWeatherErrorResponse(response : WeatherFailureModel)
}

protocol GeoCodeDelegate : AnyObject{
    func getLocationsSuccess(response : [GeoCodeResponseModel])
    func getLocationsFailure()
}

protocol ValidationDelegate : AnyObject{
    func validationFailed(errorMessage : String)
}

struct GeoCodeViewModel
{
    weak var delegate : GeoCodeDelegate?
    weak var validationDelegate : ValidationDelegate?
    func getWeatherLocations(geoCodeRequest: String)
    {
        let validationResult = SearchValidation().validate(searchRequest: geoCodeRequest)
        if validationResult.success{
            let geoCodeResource = GeoCodeResource()
            geoCodeResource.getLocationByGeoCode(geoCodeUrlInput: geoCodeRequest) { result in
                if let result = result, result.count > 0{
                    delegate?.getLocationsSuccess(response: result)
                }else{
                    delegate?.getLocationsFailure()
                }
            }
        }else{
            validationDelegate?.validationFailed(errorMessage: validationResult.error!)
        }
    }
}

struct WeatherViewModel{
    weak var delegate : WeatherDelegate?
    /**
     Method to call weather of location resource
     
     - parameter weatherRequest: requires a GeoCodeResponseModel for lat nad long
     */
    func getWeather(weatherRequest : GeoCodeResponseModel){
        let weatherResponseResource = WeatherInfoResource()
        weatherResponseResource.getWeather(geoCodeInfo: weatherRequest, completion: { result in
            if let result = result{
                switch result{
                case .success(let weatherSuccess):
                    delegate?.getWeatherSuccessResponse(response: weatherSuccess)
                case .failure(let weatherEror):
                    delegate?.getWeatherErrorResponse(response: weatherEror)
                }
            }
        })
    }
   
    /**
     method to get static weather info to display
     
     - returns: returns a static WeatherModel
     */
    func getStaticWeatherData() -> WeatherModel{
         WeatherModel(timezone: "America/New_York",current: DetailsWeatherModel(temp: 282.21, feelsLike: 278.41, humidity: 65, dewPoint: 275, visibility: 10000, weather: [WeatherInfo(id: 802,main:"Clouds",description: "scattered clouds",icon: "03d")]))
     }
    /**
     method to get the weather image based on the iconStr key given
     iconstr jey is received form the get weather api
     
     - returns: returns a ImageData
     */
    func getWeatherImage(iconStr : String) -> Data?{
        do{
           return try Data(contentsOf: URL(string: ApiEndPoints.getWeatherImage(input: iconStr))!)
        }catch{
            return nil
        }
    }
}
