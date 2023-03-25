//
//  GeoCodingModel.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation

struct GeoCodeResponseModel : Codable{
        let name: String
        let lat, lon: Double
        let country, state: String

        enum CodingKeys: String, CodingKey {
            case name
            case lat, lon, country, state
        }
    }

    typealias GeoCodeResponse = [GeoCodeResponseModel]
