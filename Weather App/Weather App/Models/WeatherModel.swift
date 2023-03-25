//
//  WeatherModel.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation

struct WeatherModel : Codable{
    var timezone : String
    var current : DetailsWeatherModel
}

struct DetailsWeatherModel  : Codable{
    var temp : Float
    var feelsLike : Float
    var humidity: Int
    var dewPoint : Int
    var visibility : Int
    var weather : [WeatherInfo]
    
    enum CodingKeys: String, CodingKey {
        case temp, feelsLike,humidity,visibility,weather
        case dewPoint = "dew_point"
    }
}


struct WeatherInfo : Codable{
    var id : Int
    var main : String
    var description : String
    var icon : String
}


struct WeatherFailureModel : Codable{
    var cod : Int
    var message : String
}

enum WeatherResponse : Codable {

    case success(WeatherModel)
    case failure(WeatherFailureModel)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let userData = try container.decode(WeatherModel.self)
            self = .success(userData)
        } catch DecodingError.keyNotFound {
            let errorData = try container.decode(WeatherFailureModel.self)
            self = .failure(errorData)
        }
    }
}
