import Foundation

public extension Date {
    
    static var zero: Date {
        return Date(timeIntervalSince1970: 0)
    }
    
    static var now: Date {
        return Date()
    }
    
    func dayCount(since date: Date, in sourceTz: TimeZone, to targetTz: TimeZone) -> UInt {
        var calendar = Calendar.current

        // Source date components
        calendar.timeZone = sourceTz
        let sourceComponents = calendar.dateComponents([.day, .month, .year], from: date)
        
        // Target date components
        calendar.timeZone = targetTz
        let targetComponents = calendar.dateComponents([.day, .month, .year], from: self)
        
        // Obtain day count between the 2 dates
        let start = calendar.date(from: sourceComponents) ?? date
        let end = calendar.date(from: targetComponents) ?? self
        let components = calendar.dateComponents([.day], from: start, to: end)
        let days = (components.day ?? 0).magnitude
        
        return days + 1 // We use 1 as first day
    }
}
