import UIKit

public extension String {
    
    /**
     Estimates the necessary size to fit text using the reference size width.
     Adjustment is done on height.
     */
    func sizeThatFits(_ size: CGSize, font: UIFont, lineHeight: CGFloat? = nil) -> CGSize {
        // Bounds
        let bound = CGSize(width: size.width, height: 0)
        
        // Paragraph
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        if let height = lineHeight {
            paragraph.minimumLineHeight = height
            paragraph.maximumLineHeight = height
        }
        
        // Estimate text size
        let textSize = self.boundingRect(with: bound,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font,
                                                      .paragraphStyle: paragraph],
                                         context: nil)
        
        // Round up and return.
        let height = textSize.height.rounded(.up)
        return CGSize(width: size.width, height: height)
    }
    
    func widthThatFits(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.width.rounded(.up)
    }
    
    func removeHTMLTags() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
