import Foundation
import Configuration
import CloudFoundryConfig

public class AdapterFactory {
    let manager: ConfigurationManager

    init(manager: ConfigurationManager) {
        self.manager = manager
    }

    public func getRobotContentAdapter() throws -> RobotContentAdapter {
      return RobotContentMemoryAdapter()
    }

}
