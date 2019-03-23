import Foundation
import ReactiveSwift
import Result

public extension Notification {
    
    static func signal(named: String) -> Signal<Notification, NoError> {
        let center = NotificationCenter.default
        let name = Notification.Name(rawValue: named)
        return center.reactive
            .notifications(forName: name)
    }
}
