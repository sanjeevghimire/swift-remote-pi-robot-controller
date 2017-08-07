import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import Application
import SwiftyJSON
import Generated

private let path = "/api/IoT/RobotContent"

do {

    HeliumLogger.use(LoggerMessageType.info)
    try initialize()
    
    // create a route to send RobotContent to MQTT Platform
    
    router.post(path){ request, response, next in
        Log.debug("POST \(path)")
        guard let contentType = request.headers["Content-Type"],
            contentType.hasPrefix("application/json") else {
                response.status(.unsupportedMediaType)
                response.send(json: JSON([ "error": "Request Content-Type must be application/json" ]))
                return next()
        }
        guard case .json(let json)? = request.body else {
            response.status(.badRequest)
            response.send(json: JSON([ "error": "Request body could not be parsed as JSON" ]))
            return next()
        }
        do {
            let model = try RobotContent(json: json)
            //call remote service
            try RemoteRobotService().sendRobotContent(model: model)
            //
            response.send(json: model.toJSON())
            next()
            
        } catch let error as ModelError {
            response.status(.unprocessableEntity)
            response.send(json: JSON([ "error": error.localizedDescription ]))
            next()
        } catch {
            Log.error("InternalServerError during handleCreate: \(error)")
            response.status(.internalServerError)
            next()
        }
    }

    
    try run()

} catch let error {
    Log.error(error.localizedDescription)
}
