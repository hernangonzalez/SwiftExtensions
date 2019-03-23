import Foundation
import ReactiveSwift
import Result
import Photos

public extension PHAsset {
    static let minProgress: Double = 0
    static let maxProgress: Double = 1
    
    enum Error: Swift.Error {
        case assetInCloud
        case assetNotAvailable
    }

    typealias ProgressObserver = Signal<Double, NoError>.Observer
    typealias RequestResult = SignalProducer<Data, Error>
    
    
    func requestData(progress: ProgressObserver) -> RequestResult {
        let manager = PHImageManager.default()
        let producer: SignalProducer<Data, Error> = SignalProducer { observer, lifetime in
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .exact
            options.isSynchronous = false
            options.isNetworkAccessAllowed = true

            // Download Progress:
            // Begin with a min progress indication.
            progress.send(value: PHAsset.minProgress)
            options.progressHandler = { value, error, stop, info in
                let value = max(PHAsset.minProgress, value)
                progress.send(value: value)
            }
            
            manager.requestImageData(for: self, options: options) { (data, _, _, info) in
                guard let data = data else {
                    let inCloud: Bool = (info?[PHImageResultIsInCloudKey] as? Bool) ?? false
                    observer.send(error: inCloud ? .assetInCloud : .assetNotAvailable)
                    return
                }
                
                // Note: Progress will never be called if data is available locally.
                // So we let know any observer that we download is complete anyway. ~ hgg.
                progress.send(value: PHAsset.maxProgress)
                
                // If we are still being observed, produce the final data.
                if !lifetime.hasEnded {
                    observer.send(value: data)
                    observer.sendCompleted()
                }
            }
        }
        
        return producer
    }
}
