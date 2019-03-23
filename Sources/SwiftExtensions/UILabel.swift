import UIKit

public extension UILabel {
    
    convenience init(font: UIFont) {
        self.init(frame: .zero)
        self.font = font
    }
    
    @objc
    func setAttributedText(_ text: String, lineHeight: CGFloat, alignment: NSTextAlignment = .natural) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.minimumLineHeight = lineHeight
        paragraph.maximumLineHeight = lineHeight
        paragraph.alignment = alignment
        attributedText = NSAttributedString(string: text, attributes: [.paragraphStyle: paragraph])
    }
}
