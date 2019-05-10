import Foundation
import UIKit

// MARK: String
public extension String {
    
    static var empty: String {
        return ""
    }
    
    var url: URL? {
        return isEmpty ? nil : URL(string: self)
    }
}

// MARK: Dictionary
public extension Dictionary {
    
    static var empty: Dictionary {
        return [:]
    }
}

// MARK: Array
public extension Array {
    
    static var empty: Array {
        return []
    }
    
    var middle: Element? {
        guard !isEmpty else {
            return nil
        }
        return self[count / 2]
    }
}

public extension Array where Element: Equatable {
    
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
    
    func uniques() -> [Element] {
        var all = self
        all.removeDuplicates()
        return all
    }
}

public extension ArraySlice where Element: Comparable {
    /// Produces an array of slices representing the original
    /// slice split at each point where a user-supplied
    /// predicate evalutes to true.
    ///
    /// - Parameter predicate: a closure that tests whether a new element
    ///   should be added to the current partion
    /// - Parameter element: the element to be tested
    /// - Parameter nextElement: the successive element to be tested
    /// - Parameter maxPartitions: The maximum number of
    ///   subslices that can be produced
    ///
    /// - Returns: An array of array slices
    fileprivate func sliced(where predicate: (_ element: Element, _ nextElement: Element) -> Bool, maxPartitions: Int = .max ) -> [ArraySlice<Element>] {
        
        guard !isEmpty else { return [] }
        guard maxPartitions > 1, count > 1 else { return [self] }
        var (partitionIndex, nextPartitionIndex) = (startIndex, indices.index(after: startIndex))
        
        while nextPartitionIndex < endIndex, !predicate(self[partitionIndex], self[nextPartitionIndex]) {
            (partitionIndex, nextPartitionIndex) = (nextPartitionIndex, indices.index(after: nextPartitionIndex))
        }
        
        guard partitionIndex < endIndex else { return [self] }
        
        let (firstSlice, remainingSlice) = (self[startIndex ..<  nextPartitionIndex], self[nextPartitionIndex ..< endIndex])
        let rest = remainingSlice.sliced(where: predicate, maxPartitions: maxPartitions - 1)
        
        return [firstSlice] + rest
    }
}

public extension Array where Element: Comparable {
    /// Produces an array of slices representing an
    /// array split at each point where a user-supplied
    /// predicate evalutes to true.
    ///
    /// ```
    /// [1, 2, 2, 3, 3, 3, 1]
    ///   .sliced(where: !=)
    /// // [ArraySlice([1]), ArraySlice([2, 2]), ArraySlice([3, 3, 3]), ArraySlice([1])]
    /// ```
    ///
    /// - Parameter predicate: a closure that tests whether a new element
    ///   should be added to the current partion
    /// - Parameter element: the element to be tested
    /// - Parameter nextElement: the successive element to be tested
    /// - Parameter maxPartitions: The maximum number of slices
    ///
    /// - Returns: An array of array slices
    func sliced(where predicate: (_ element: Element, _ nextElement: Element) -> Bool, maxPartitions: Int = .max ) -> [ArraySlice<Element>] {
        return self[startIndex ..< endIndex].sliced(where: predicate, maxPartitions: maxPartitions)
    }
}

// MARK: UIEdgeInsets
public extension UIEdgeInsets {
    
    var horizontal: CGFloat {
        return left + right
    }
    
    var vertical: CGFloat {
        return top + bottom
    }
    
    static func equal(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}


// MARK: CGSize
public extension CGSize {
    
    var aspectRatio: CGFloat {
        return width / height
    }
    
    static func square(_ side: CGFloat) -> CGSize {
        return .init(width: side, height: side)
    }
}

public func * (size: CGSize, magnitude: CGFloat) -> CGSize {
    return CGSize(width: size.width * magnitude, height: size.height * magnitude)
}
