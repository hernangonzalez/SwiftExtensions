import UIKit

extension UIStoryboardSegue: ReuseIdentifiable {
    
    convenience init(source: UIViewController, destination: UIViewController) {
        let identifier = type(of: self).identifier
        self.init(identifier: identifier, source: source, destination: destination)
    }
}
