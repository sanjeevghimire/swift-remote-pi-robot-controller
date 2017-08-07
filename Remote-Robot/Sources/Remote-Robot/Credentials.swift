//
//  Credentials.swift
//  Remote-Robot
//
//  Created by Sanjeev Ghimire on 7/17/17.
//
//

public struct Credentials {
    //IOT device credentials from bluemix
   public static let API_KEY = "<key>"
   public static let API_TOKEN = "<password>"
   public static let IOT_CLIENT = "a:<orgid>:RemoteRobot"
   public static let IOT_HOST = "<orgid>.messaging.internetofthings.ibmcloud.com"
   public static let IOT_PORT = 1883
   public static let IOT_TOPIC = "iot-2/type/<device_type>/id/<deviceid>/evt/<event>/fmt/json"
    
}
