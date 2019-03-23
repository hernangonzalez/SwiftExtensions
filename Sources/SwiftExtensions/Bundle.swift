import Foundation
import Logger

public extension Bundle {
    
    func decodePlist<Type: Decodable>(named name: String) -> Type? {
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        let data = path.flatMap { FileManager.default.contents(atPath: $0) }
        let decoder = PropertyListDecoder()
        do {
            return try decoder.decode(Type.self, from: data!)
        } catch {
            logger.error(error)
            return nil
        }
    }
        
    var shortVersion: String {
        let string = infoDictionary?["CFBundleShortVersionString"] as? String
        return string ?? .empty
    }
    
    var bundleVersion: String {
        let string = infoDictionary?["CFBundleVersion"] as? String
        return string ?? .empty
    }
    
    var name: String {
        let string = infoDictionary?["CFBundleName"] as? String
        return string ?? .empty
    }
}

public extension ReuseIdentifiable where Self: Decodable {
    
    static func decodeFromPlist() -> Self? {
        let bundle = Bundle.main
        return bundle.decodePlist(named: Self.identifier)
    }
}
