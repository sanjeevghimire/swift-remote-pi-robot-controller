import SwiftyJSON

public struct RobotContent {
    public let id: String?
    public let text: String
    public let blinkColor: String

    public init(id: String?, text: String, blinkColor: String) {
        self.id = id
        self.text = text
        self.blinkColor = blinkColor
    }

    public init(json: JSON) throws {
        // Required properties
        guard json["text"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "text")
        }
        guard let text = json["text"].string else {
            throw ModelError.propertyTypeMismatch(name: "text", type: "string", value: json["text"].description, valueType: String(describing: json["text"].type))
        }
        self.text = text
        guard json["blinkColor"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "blinkColor")
        }
        guard let blinkColor = json["blinkColor"].string else {
            throw ModelError.propertyTypeMismatch(name: "blinkColor", type: "string", value: json["blinkColor"].description, valueType: String(describing: json["blinkColor"].type))
        }
        self.blinkColor = blinkColor

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "text", "blinkColor"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> RobotContent {
      return RobotContent(id: newId, text: text, blinkColor: blinkColor)
    }

    public func updatingWith(json: JSON) throws -> RobotContent {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["text"].exists() &&
           json["text"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "text", type: "string", value: json["text"].description, valueType: String(describing: json["text"].type))
        }
        let text = json["text"].string ?? self.text

        if json["blinkColor"].exists() &&
           json["blinkColor"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "blinkColor", type: "string", value: json["blinkColor"].description, valueType: String(describing: json["blinkColor"].type))
        }
        let blinkColor = json["blinkColor"].string ?? self.blinkColor

        return RobotContent(id: id, text: text, blinkColor: blinkColor)
    }

    public func toJSON() -> JSON {
        var result = JSON([
            "text": JSON(text),
            "blinkColor": JSON(blinkColor),
        ])
        if let id = id {
            result["id"] = JSON(id)
        }

        return result
    }
}
