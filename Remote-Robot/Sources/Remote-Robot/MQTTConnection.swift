//
//  MQTTConnection.swift
//  Remote-Robot
//
//  Created by Sanjeev Ghimire on 7/17/17.
//
//

import Foundation
import Aphid

class MQTTConnection: Aphid, MQTTDelegate{
    
    init() {
        super.init(clientId: Credentials.IOT_CLIENT, cleanSess: true, username: Credentials.API_KEY, password: Credentials.API_TOKEN, host: Credentials.IOT_HOST, port: Int32(Credentials.IOT_PORT))
        super.delegate = self
    }
    
    func didConnect() {
        print("connected!")
    }
    func didLoseConnection(error: Error?) {
        print("connection lost ",error!)
    }
    
    func didCompleteDelivery(token: String) {
        print(token)
    }
    
    public func didReceiveMessage(topic: String, message: String) {
        print(topic, message)
    }
}
