import UIKit.UIViewController

public extension UIViewController {
    
    func addChild(controller: UIViewController) {
        controller.willMove(toParent: self)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
}
