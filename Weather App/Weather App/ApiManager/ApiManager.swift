//
//  ApiManager.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation
import Alamofire

class HttpManager{
    
    /**
     A Generic APi call method used for API calling that can return the specified type
     
     - parameter URLString:  Url that need to be hit
     - parameter method:     http method
     - parameter headers:    Headers of API
     - parameter parameters: parameters oif API
     - parameter apiName:    apiname of calling api
     - parameter resultType: the result type from api (can be any model)
     */
    func performRequestWithURL<T:Decodable>(_ URLString: URLConvertible, method: HTTPMethod , headers: HTTPHeaders?, parameters: [String: Any]?,apiName : String, resultType : T.Type,completionHandler :@escaping(Result<T,Error>)->Void) {
        
        debugPrint("URL:", URLString)
        
        AF.request(URLString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response{ responseData in
            if (responseData.error == nil){
                if let receivedData = responseData.data{
                    
                    debugPrint("RESPONSE:", (String(data: receivedData, encoding: .utf8) as AnyObject))
                    
                    do {
                        let response = try JSONDecoder().decode(resultType.self, from: receivedData)
                        completionHandler(.success(response))
                    }catch let errorConversion{
                        completionHandler(.failure(errorConversion))
                    }
                }else{
                    completionHandler(.failure(responseData.error ?? CustomError.unknownError))
                }
            }else{
                debugPrint("Error:", responseData.error ?? "")
                completionHandler(.failure(responseData.error ?? CustomError.unknownError))
            }
        }
    }
}
