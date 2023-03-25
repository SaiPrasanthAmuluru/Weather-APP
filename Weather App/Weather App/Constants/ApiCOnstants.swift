//
//  ApiCOnstants.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation

struct ApiEndPoints{
    private static var apiKey : String = "b0f25eeca9003a6c42d462dbe88eee1d"

    /**
     Methos that returns a string of get locations
     
     - parameter input: takes in search string
     
     - returns: returns a final url with input string
     */
    static func getGeoCodeUrl(input : String) -> String {
        return "http://api.openweathermap.org/geo/1.0/direct?q=\(input)&limit=10&appid=\(apiKey)"
    }
    
    /**
     Methos that returns a string of get weather
     
     - parameter input: GeoCodeResponseModel  takes in GeoCodeResponseModel for lat long to be added in to the string
     
     - returns: returns a final url with input string
     */
    static func getweatherInfoUrl(input : GeoCodeResponseModel) -> String {
        return "https://api.openweathermap.org/data/3.0/onecall?lat=\(input.lat)&lon=\(input.lon)&exclude=hourly,daily&appid=\(apiKey)"
    }
    
    /**
     Methos that returns a string of get image data of weather
     
     - parameter input: takes in image code string
     
     - returns: returns a final url with input string added
     */
    static func getWeatherImage(input : String) -> String{
        return  "https://openweathermap.org/img/wn/\(input)@2x.png"
    }
}
