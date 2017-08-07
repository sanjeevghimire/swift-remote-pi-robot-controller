//
//  RobotContent.swift
//  Remote-UI
//
//  Created by Sanjeev Ghimire on 7/17/17.
//  Copyright © 2017 Sanjeev Ghimire. All rights reserved.
//
import UIKit
import Foundation
import os.log


class RobotContent: NSObject, NSCoding {
    public let id: String?
    public let text: String
    public let blinkColor: String
    
    public init(id: String?, text: String, blinkColor: String) {
        self.id = id
        self.text = text
        self.blinkColor = blinkColor
    }
    
    //MARK: Types
    
    struct PropertyKey {
        static let id = "id"
        static let text = "text"
        static let blinkColor = "blinkColor"
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(text, forKey: PropertyKey.text)
        aCoder.encode(blinkColor, forKey: PropertyKey.blinkColor)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let blinkColor = aDecoder.decodeObject(forKey: PropertyKey.blinkColor) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }

        
        
        // Must call designated initializer.
        self.init(id: id, text: text, blinkColor: blinkColor)
        
    }
}


extension RobotContent {
    func asServerRobotContent() -> ServerRobotContent {
        let serverRobotContent = ServerRobotContent()
        serverRobotContent.id = "1"
        serverRobotContent.text = self.text
        serverRobotContent.blinkColor = self.blinkColor
        return serverRobotContent
    }
}
