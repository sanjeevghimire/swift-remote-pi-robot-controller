public protocol RobotContentAdapter {
    func findAll(onCompletion: @escaping ([RobotContent], Error?) -> Void)
    func create(_ model: RobotContent, onCompletion: @escaping (RobotContent?, Error?) -> Void)
    func deleteAll(onCompletion: @escaping (Error?) -> Void)

    func findOne(_ maybeID: String?, onCompletion: @escaping (RobotContent?, Error?) -> Void)
    func update(_ maybeID: String?, with model: RobotContent, onCompletion: @escaping (RobotContent?, Error?) -> Void)
    func delete(_ maybeID: String?, onCompletion: @escaping (RobotContent?, Error?) -> Void)
}
