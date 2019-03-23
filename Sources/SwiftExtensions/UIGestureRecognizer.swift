import UIKit.UIGestureRecognizer

extension UIGestureRecognizer.State: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .began: return "began"
        case .cancelled: return "cancelled"
        case .changed: return "changed"
        case .ended: return "ended"
        case .failed: return "failed"
        case .possible: return "possible"
        }
    }
}
