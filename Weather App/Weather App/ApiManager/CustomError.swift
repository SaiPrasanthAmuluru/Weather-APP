//
//  CustomError.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation

enum CustomError : Error{
    case noNetwork
    case invalidConversion
    case noToken
    case unknownError
}
extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return NSLocalizedString("no_internet_connection_available", comment: "NO Internet")
        case .invalidConversion:
            return NSLocalizedString( "Invalid conversion to desired Model", comment: "InvalidConversion")
        case .noToken:
            return NSLocalizedString("cannot_perform_api_call", comment: "Can not call api")
        case .unknownError:
            return NSLocalizedString("Something went wrong. Please try again.", comment: "Unknown error")
        }
    }
}
