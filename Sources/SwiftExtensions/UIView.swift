import UIKit.UIView
import ReactiveSwift

public extension UIView {
            
    /**
     Remove all subviews
     */
    func removeSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    /**
        A convenience function to configure a default drop shadow effect.
     */
    @objc func configureShadow() {
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.12
        layer.masksToBounds = false
        updateShadowPath()
    }
    
    func updateShadowPath() {
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
#if targetEnvironment(simulator)
    /**
     Debug view layouts by assigning random colors.
     */
    func debugColors() {
        backgroundColor = .random
        subviews.forEach { $0.debugColors() }
    }
#endif
}

public extension UIColor {
    
    static var random: UIColor {
        let r = CGFloat(arc4random_uniform(255)) / 255.0
        let g = CGFloat(arc4random_uniform(255)) / 255.0
        let b = CGFloat(arc4random_uniform(255)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

public class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
}

public class RoundView: UIView {
    
    override public func layoutSubviews() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        super.layoutSubviews()
    }
}
