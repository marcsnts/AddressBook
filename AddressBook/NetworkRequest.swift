//
//  NetworkRequest.swift
//  AddressBook
//
//  Created by Marc Santos on 2017-01-20.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkRequestType: String {
    case Post = "POST",
    Get = "GET",
    Put = "PUT"
}

class NetworkRequest {
    
    class func createRequest(requestType: NetworkRequestType, url: String, data: [[String:Any]]?) -> URLRequest? {
        
        guard let url = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        //Set header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = data {
            do {
                request.httpBody  = try JSONSerialization.data(withJSONObject: data, options: [])
            }
            catch {
                print("[ERROR]Could not serialize body to JSON")
            }
        }
        
        return request
    }
    
    
}
