//
//  WeatherInforesource.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation
struct WeatherInfoResource
{
    /**
     Method to call api manager method for getting the weather of selecetd location
     
     - parameter geoCodeInfo - Used to generate / add the input (lat , long)to the url.
                                completion - gices back WeatherResponse.
     */
    func getWeather(geoCodeInfo: GeoCodeResponseModel, completion : @escaping (_ result: WeatherResponse?) -> Void)
    {
        let geoCodeUrl = ApiEndPoints.getweatherInfoUrl(input: geoCodeInfo)
        
        let httpUtility = HttpManager()
        
        httpUtility.performRequestWithURL(geoCodeUrl, method: .get, headers: nil, parameters: nil, apiName: "", resultType: WeatherResponse.self) { geoCodeResponse in
            switch geoCodeResponse{
            case .success(let weatherResponse):
                completion(weatherResponse)
            case .failure(let error):
                completion(nil)
            }
        }
    }
}
