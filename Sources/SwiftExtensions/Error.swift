import UIKit
import ReactiveSwift

// MARK: KeyedError
public protocol KeyedError: LocalizedError {
    var errorKey: String { get }
}

public extension KeyedError where Self: RawRepresentable, Self.RawValue == String {
    
    var errorKey: String {
        return rawValue
    }
}

// MARK: ErrorRenderer
public protocol ErrorRenderer: AnyObject {
    func showError(_ error: Error)
}

// MARK: UIView
extension UIView: ErrorRenderer {
    
    public func showError(_ error: Error) {
        let presenter = window?.rootViewController
        presenter?.showError(error)
    }
}

// MARK: UIViewController
extension UIViewController: ErrorRenderer {
    
    public func showError(_ error: Error) {
        let title: String?
        if let locale = error as? LocalizedError {
            title = locale.failureReason
        } else {
            title = nil
        }
        
        alert(error.localizedDescription, title: title)
    }
    
    func alert(_ message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

