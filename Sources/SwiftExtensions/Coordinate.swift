import Foundation
import MapKit

// MARK: CLLocationCoordinate2D
extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return (lhs.latitude == rhs.latitude) && (rhs.longitude == rhs.longitude)
    }
}

public extension CLLocationCoordinate2D {
    var isValid: Bool {
        return CLLocationCoordinate2DIsValid(self)
    }
    
    static var none: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: .greatestFiniteMagnitude, longitude: .greatestFiniteMagnitude)
    }
    
    var isRepresentable: Bool {
        // Warning: Mapbox is not able to draw NaN values, or latitudes over the +/- 90 degres (absolute)
        // https://fabric.io/polarsteps/ios/apps/com.polarsteps.polarsteps/issues/5b2d62e56007d59fcd9224f1?time=last-twenty-four-hours
        guard isValid else {
            return false
        }
        return latitude.magnitude <= 90
    }
    
    var normalized: CLLocationCoordinate2D {
        var coord = self
        if coord.longitude < -180 {
            coord.longitude += 360
        } else if coord.longitude > 180 {
            coord.longitude -= 360
        }
        if coord.latitude > 90 {
            coord.latitude -= 180
        } else if coord.latitude < -90 {
            coord.latitude += 180
        }
        return coord
    }
    
    var flightCompatible: CLLocationCoordinate2D {
        var coord = self
        if coord.longitude < 0 {
            coord.longitude += 360
        }
        return coord
    }
    
    func distance(to target: CLLocationCoordinate2D) -> CLLocationDistance {
        let origin = MKMapPoint.init(self);
        let destine = MKMapPoint.init(target);
        return origin.distance(to: destine);
    }
    
    func path(to target: CLLocationCoordinate2D) -> [CLLocationCoordinate2D] {
        let segments = distance(to: target) / (1000 * 50) // We'll use 1 step every 50 km.
        let steps = max(25, min(150, segments.rounded())) // Keep steps between [25 - 150].
        let auxiliary = thirdPoint(p1: self, p2: target)
        return bezierPath(p1: self, toPoint: target, auxiliary: auxiliary, steps: steps)
    }
    
    func bearing(to target: CLLocationCoordinate2D) -> Double {
        return calculateBearing(from: self, to: target)
    }
}

// MARK: CLLocation
public extension CLLocation {
    
    convenience init(_ coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude,
                  longitude: coordinate.longitude)
    }
}

// MARK: CLLocationDistance
public extension CLLocationDistance {
    var km: CLLocationDistance {
        return self * 1000
    }
}

// MARK: Path Helpers
private func thirdPoint(p1: CLLocationCoordinate2D, p2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
    let center = CLLocationCoordinate2D(latitude: (p1.latitude + p2.latitude) / 2.0,
                                        longitude: (p1.longitude + p2.longitude) / 2.0)
    let p = CLLocationCoordinate2D(latitude: p1.latitude - p2.latitude, longitude: p1.longitude - p2.longitude)
    var n = CLLocationCoordinate2D(latitude: -p.longitude, longitude: p.latitude)
    let length = sqrt(n.latitude * n.latitude  + n.longitude * n.longitude)
    n.latitude /= length
    n.longitude /= length
    
    // Distance
    let latDist = (p2.latitude.magnitude - p1.latitude.magnitude).magnitude
    let lngDist = (p2.longitude.magnitude - p1.longitude.magnitude).magnitude
    let distance = max(latDist, lngDist) * 0.4
    
    // Locate
    let result = CLLocationCoordinate2D(latitude: center.latitude + (distance * n.latitude),
                                        longitude: center.longitude + (distance * n.longitude))
    return result
}

private func bezierPath(p1: CLLocationCoordinate2D, toPoint p2: CLLocationCoordinate2D, auxiliary: CLLocationCoordinate2D, steps: Double) -> [CLLocationCoordinate2D] {
    var targetPoints = [CLLocationCoordinate2D]()
    
    for index in 0 ... Int(steps) {
        let t = Double(index) / steps
        
        // Start point of the Bezier curve
        let bezier1x = p1.longitude + (auxiliary.longitude - p1.longitude) * t
        let bezier1y = p1.latitude + (auxiliary.latitude - p1.latitude) * t
        
        // End point of the Bezier curve
        let bezier2x = auxiliary.longitude + (p2.longitude - auxiliary.longitude) * t
        let bezier2y = auxiliary.latitude + (p2.latitude - auxiliary.latitude) * t
        
        let bezierPoint = CLLocationCoordinate2D(latitude: bezier1y + (bezier2y - bezier1y) * t,
                                                 longitude: bezier1x + (bezier2x - bezier1x) * t)
        targetPoints.append(bezierPoint)
    }
    
    return targetPoints
}

private func calculateBearing(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
    let x1 = from.longitude * (Double.pi / 180.0)
    let y1 = from.latitude  * (Double.pi / 180.0)
    let x2 = to.longitude   * (Double.pi / 180.0)
    let y2 = to.latitude    * (Double.pi / 180.0)
    
    let dx = x2 - x1
    let sita = atan2(sin(dx) * cos(y2), cos(y1) * sin(y2) - sin(y1) * cos(y2) * cos(dx))
    
    return sita * (180.0 / Double.pi)
}
