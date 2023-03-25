//
//  CommonFunctionalities.swift
//  Weather App
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import Foundation
import Alamofire

struct NetworkState {
    static let shared = NetworkState()
    private init(){}
    /**
     Method to check network Connectivity
     - returns Boolean value of network connectivity( true / false)
     */
    func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension UIViewController{
    /**
     A common method to display the alert message
     
     - parameter title:   Title for Alert
     - parameter message: Message for Alert
     */
    func showAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Constants.okAlertTitle, style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
