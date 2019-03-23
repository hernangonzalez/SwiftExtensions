import Foundation

public extension Calendar {
    
    func isElapsed(from date: Date, count: Int, component: Component = .day, to target: Date = .now) -> Bool {
        let components = dateComponents([component], from: date, to: target)
        let enough = components.value(for: component).map { $0 >= count } ?? true
        return enough
    }
}
