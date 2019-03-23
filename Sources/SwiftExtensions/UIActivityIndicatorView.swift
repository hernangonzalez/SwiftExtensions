import UIKit.UIActivityIndicatorView

public extension UIActivityIndicatorView {
    
    func setAnimating(_ value: Bool) {
        if value {
            startAnimating()
        } else {
            stopAnimating()
        }
    }
}
