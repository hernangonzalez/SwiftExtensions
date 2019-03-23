import Foundation
import ReactiveSwift
import Logger

public extension FileManager {
    
    enum Error: Swift.Error {
        case noData
    }
    
    func content(atURL url: URL) -> SignalProducer<Data, Error> {
        let queue = DispatchQueue.global()
        return SignalProducer { observer, lifetime in
            queue.async {
                guard let data = url.data else {
                    logger.verbose("No data at: " + url.path)
                    observer.send(error: Error.noData)
                    return
                }
                
                logger.info("Loaded: " + url.path)
                observer.send(value: data)
                observer.sendCompleted()
            }
        }
    }
}
