//
//  RemoteRobotAPI.swift
//  Remote-UI
//
//  Created by Sanjeev Ghimire on 7/17/17.
//  Copyright © 2017 Sanjeev Ghimire. All rights reserved.
//

import Foundation
import ObjectMapper
import BMSCore

class RemoteRobotAPI : RemoteRobotUtility{
    
    /**
     Create a new instance of the model and persist it
     
     - parameter data: Model instance data
     - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
     - parameter returnedData: The data that this method is retrieving from the server
     - parameter response: The HTTP response returned by the server
     - parameter error: An error that prevented a successful request
     */
    public static func RobotContentCreate(data: ServerRobotContent? = nil, completionHandler: @escaping (_ returnedData: ServerRobotContent?, _ response: Response?, _ error: Error?) -> Void) {
        
        let path = "/IoT/RobotContent"
        let components = URLComponents(string: self.basePath + path)
        
        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")        
        request.httpBody = convertToData(data)
        
        let urlSession = BMSURLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: request) { (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            let bmsResponse: Response = Response(responseData: data, httpResponse: httpResponse, isRedirect: false)
            
            guard httpResponse != nil else {
                completionHandler(nil, nil, error)
                return
            }
            
            guard error == nil else {
                completionHandler(nil, bmsResponse, error)
                return
            }
            
            if 200 ..< 300 ~= httpResponse!.statusCode,
                httpResponse!.statusCode == 200,
                let data = data {
                
                let returnValue = extractResponseFromData(data: data, type: ServerRobotContent.self)
                completionHandler(returnValue, bmsResponse, error)
            } else {
                completionHandler(nil, bmsResponse, error)
            }
            }.resume()
    }    
}
