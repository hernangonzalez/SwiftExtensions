import UIKit

public extension UIViewAnimating {
    
    var isInactive: Bool {
        return state == .inactive
    }
    
    var isActive: Bool {
        return state == .active
    }
}
