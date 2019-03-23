import UIKit.UIStackView

public extension UIStackView {
    
    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
        }
        removeSubviews()
    }
}

public extension Array where Element: UIView {
    
    func stacked(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: self)
        stack.axis = axis
        return stack
    }
}
