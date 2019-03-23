import Foundation
import Logger

public extension UserDefaults {
    
    func set(_ date: Date, forKey key: String) {
        set(date as NSDate, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
    
    func save<Type: Codable>(_ codable: Type, with key: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(codable)
            self.set(data, forKey: key)
        } catch {
            logger.error(error)
        }
    }
    
    static var group: UserDefaults? {
        return UserDefaults(suiteName: "group.com.polarsteps.Polarsteps")
    }
}

// MARK: UserDefaultsCodable
public protocol UserDefaultsCodable: Codable {
    var defaultsKey: String { get }
}

public extension UserDefaultsCodable {
    
    func save(_ defaults: UserDefaults = .standard) {
        defaults.save(self as Self, with: defaultsKey)
    }
    
    static func restore(_ defaults: UserDefaults = .standard, key: String) -> Self? {
        let data = defaults.data(forKey: key)
        return data.flatMap {
            let decoder = JSONDecoder()
            return try? decoder.decode(self, from: $0)
        }
    }
}
