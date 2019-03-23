import UIKit

public extension UIBarButtonItem {
    
    @objc static var empty: UIBarButtonItem {
        return UIBarButtonItem(title: .empty, style: .plain, target: nil, action: nil)
    }
}

public extension UINavigationController {

    @objc func popViewControllerAnimated() {
        popViewController(animated: true)
    }
}

public extension UIViewController {

    @objc func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
}
