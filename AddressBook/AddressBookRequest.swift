//
//  AddressBookRequest.swift
//  AddressBook
//
//  Created by Marc Santos on 2017-01-20.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension NetworkRequest {
    
    class func getRandomUsers(numberOfUsers: Int, successHandler: @escaping (_ json: JSON) -> Void) {
        
        let randomUserBaseURL = "https://randomuser.me/api/?nat=ca&results="
        
        let url = randomUserBaseURL.appending(String(numberOfUsers))
        
        guard let request = createRequest(requestType: .Get, url: url, data: nil) else {
            return
        }
        
        Alamofire.request(request).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                successHandler(JSON(value))
            case .failure(let error):
                print(error)
            }
        }
        
        
        
        
    }
    
}
