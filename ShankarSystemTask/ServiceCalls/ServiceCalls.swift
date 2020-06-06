//
//  ServiceCalls.swift
//  ShankarSystemTask
//
//  Created by Shankar Lakkimsetti on 06/06/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

class ServiceCalls: NSObject {
    static let sharedInstance: ServiceCalls = {
        let instance = ServiceCalls()
        return instance
    }()
    
    func getDataFromUrl(urlString: String ,completionHandler:@escaping ( _ success:Bool,  _ data: AnyObject?) -> Void) {
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let _ = String(data: data, encoding: .utf8) {
                   do {
                    let resultJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]]
    
                     completionHandler(true,resultJson as AnyObject)
                    }catch
                    {
                        completionHandler(false,"something went wrong" as AnyObject)
                    }

                }
            }
        }
        task.resume()
    }
}

