//
//  File.swift
//  Remote-Robot
//
//  Created by Sanjeev Ghimire on 7/20/17.
//
//

import Foundation
import Aphid
import Generated

public class RemoteRobotService{
       
    public func sendRobotContent(model: RobotContent) throws{
        let client = MQTTConnection()
        try client.connect()
        client.publish(topic: Credentials.IOT_TOPIC, withMessage: model.toJSON().rawString()!)
    
        while config.status == ConnectionStatus.connected {                        
            sleep(10)
        }
    }
    
    
}
