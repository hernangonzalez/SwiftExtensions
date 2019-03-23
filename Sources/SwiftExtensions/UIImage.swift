import Foundation
import ReactiveSwift
import UIKit.UIImage
import Result

//extension UIImage {
//
//    func resize(to target: CGSize) -> UIImage {
//        return kf.resize(to: target)
//    }
//}

// MARK: Reactive
public extension UIImage {
    
    enum Error: Swift.Error {
        case jpeg
    }
    
//    func resize(to size: CGSize, mode: ContentMode) -> SignalProducer<UIImage, NoError> {
//        return SignalProducer { observer, _ in
//            let result = self.kf.resize(to: size, for: mode)
//            observer.send(value: result)
//            observer.sendCompleted()
//        }
//    }
    
    func asJPEG(compression: CGFloat) -> Result<Data, Error> {
        guard let data = jpegData(compressionQuality: compression) else {
            return Result(error: .jpeg)
        }
        return Result(value: data)
    }
}
