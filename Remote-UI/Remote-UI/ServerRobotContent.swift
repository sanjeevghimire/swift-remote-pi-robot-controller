//
//  ServerRobotContent.swift
//  Remote-UI
//
//  Created by Sanjeev Ghimire on 7/19/17.
//  Copyright © 2017 Sanjeev Ghimire. All rights reserved.
//

import Foundation
import ObjectMapper

public class ServerRobotContent: Mappable {
    
    public var id: String?
    public var text: String?
    public var blinkColor: String?
    
    
    public init() {}
    
    
    // MARK: ObjectMapper
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        
        self.id <- map["id"]
        self.text <- map["text"]
        self.blinkColor <- map["blinkColor"]
        
    }

    
    
    
}
