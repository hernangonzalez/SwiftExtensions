import Foundation
import CoreLocation

// MARK: Operators
infix operator <| : MultiplicationPrecedence
infix operator <|? : MultiplicationPrecedence
infix operator <|| : MultiplicationPrecedence

func <| <K> (left: KeyedDecodingContainer<K>, right: K) throws -> Date {
    return try left.decode(Date.self, forKey: right)
}

func <| <K> (left: KeyedDecodingContainer<K>, right: K) throws -> CLLocationDegrees {
    return try left.decode(CLLocationDegrees.self, forKey: right)
}

func <| <K> (left: KeyedDecodingContainer<K>, right: K) throws -> String {
    return try left.decode(String.self, forKey: right)
}

func <| <K> (left: KeyedDecodingContainer<K>, right: K) throws -> URL {
    return try left.decode(URL.self, forKey: right)
}

func <| <K> (left: KeyedDecodingContainer<K>, right: K) -> Bool {
    do {
        return try left.decode(Bool.self, forKey: right)
    } catch {
        return false
    }
}

func <| <K> (left: KeyedDecodingContainer<K>, right: K) throws -> Int {
    return try left.decode(Int.self, forKey: right)
}

func <| <K> (left: KeyedDecodingContainer<K>, right: K) throws -> UUID {
    return try left.decode(UUID.self, forKey: right)
}

// MARK: Optionals
func <|? <K> (left: KeyedDecodingContainer<K>, right: K) -> URL? {
    return (try? left.decodeIfPresent(URL.self, forKey: right)).flatMap { $0 }
}

func <|? <K> (left: KeyedDecodingContainer<K>, right: K) -> Double? {
    return (try? left.decodeIfPresent(Double.self, forKey: right)).flatMap { $0 }
}

func <|? <K> (left: KeyedDecodingContainer<K>, right: K) throws -> Bool? {
    return try left.decodeIfPresent(Bool.self, forKey: right)
}

func <|? <K> (left: KeyedDecodingContainer<K>, right: K) -> Date? {
    return (try? left.decodeIfPresent(Date.self, forKey: right)).flatMap { $0 }
}

func <|? <K> (left: KeyedDecodingContainer<K>, right: K) -> String? {
    return (try? left.decodeIfPresent(String.self, forKey: right)).flatMap { $0 }
}
