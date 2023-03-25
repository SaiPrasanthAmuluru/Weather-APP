//
//  SearchValidation.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation
struct SearchValidation {

    /**
     Methos to validate the search text input
     
     - parameter searchRequest: takes string as input for validation
     
     - returns: returns a SearchValidationResult with validation result of true or false with a message
     */
    func validate(searchRequest: String) -> SearchValidationResult
    {
        if(searchRequest.isEmpty)
        {
            return SearchValidationResult(success: false, error: "Search text is empty")
        }else if (searchRequest.count < 3){
            return SearchValidationResult(success: false, error: "Please enter more than 3 characters.")
        }

        return SearchValidationResult(success: true, error: nil)
    }

}
