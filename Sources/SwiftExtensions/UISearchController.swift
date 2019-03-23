import UIKit.UISearchController

public extension UISearchController {
    
    var isInputEmpty: Bool {
        return searchBar.text.map { $0.isEmpty } ?? true
    }
}
