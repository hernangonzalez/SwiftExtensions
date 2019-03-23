import Foundation
import Photos

public extension PHFetchResult where ObjectType == PHAsset {
    
    func allAssets() -> [PHAsset] {
        return allAssets(limit: count)
    }
    
    func allAssets(limit: Int) -> [PHAsset] {
        guard count > 0 else {
            return []
        }
         
        let rhs = min(limit - 1, count - 1)
        let range = IndexSet(0...rhs)
        let items: [PHAsset] = objects(at: range)
        
        return items
    }
}
