//
//  GeoCodeResource.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation
struct GeoCodeResource
{
    /**
     Method to call api manager method for getting the locations from given string
     
     - parameter geoCodeUrlInput - Used to generate / add the input to the url.
                                completion - gices back an array of GeoCodeResponseModel.
     */
    func getLocationByGeoCode(geoCodeUrlInput: String, completion : @escaping (_ result: [GeoCodeResponseModel]?) -> Void)
    {
        let geoCodeUrl = ApiEndPoints.getGeoCodeUrl(input: geoCodeUrlInput)
                
        let httpUtility = HttpManager()
        
        httpUtility.performRequestWithURL(geoCodeUrl, method: .get, headers: nil, parameters: nil, apiName: "", resultType: GeoCodeResponse.self) { geoCodeResponse in
            switch geoCodeResponse{
            case .success(let locations):
                completion(locations)
            case . failure(let error):
                completion(nil)
            }
            
        }
    }
}
