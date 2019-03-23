import Foundation
import UIKit.UIApplication
import Logger

public extension NSURL {
    
    @objc
    func openInDevice() {
        let url = self as URL
        url.openInDevice()
    }
}

public extension URL {
    
    var data: Data? {
        if !isFileURL {
            logger.warning("Path is not local.")
        }
        if Thread.current.isMainThread {
            logger.warning("Operation will block your UI.")
        }
        return try? Data(contentsOf: self)
    }
    
    var canOpenInDevice: Bool {
        return UIApplication.shared.canOpenURL(self)
    }
    
    func openInDevice() {
        UIApplication.shared.open(self, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    func appendingQuery(item: URLQueryItem) -> URL? {
        guard var componentes = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        
        var items = componentes.queryItems ?? .empty
        items.append(item)
        componentes.queryItems = items
        return componentes.url
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
