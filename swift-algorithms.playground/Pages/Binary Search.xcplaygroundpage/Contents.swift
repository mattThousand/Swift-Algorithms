/**
 Binary Search
 
 Recursively splits the array in half until the value is found.
 
 If there is more than one occurrence of the search key in the array, then
 there is no guarantee which one it finds.
 
 Note: The array must be sorted!
 **/

import Foundation

public typealias Index = Int

enum SearchError: Error { case unsortedInput, searchKeyNotPresent }

extension Array where Element: Comparable {
    var isSorted: Bool {
        for idx in 1..<count {
            if self[idx - 1] > self[idx] { return false }
        }
        return true
    }
}

// The recursive version of binary search.

public func myBinarySearch<T: Comparable>(_ sortedCollection: [T], searchKey: T, idxRange: Range<Index>) throws -> Index? {

    guard sortedCollection.isSorted else { throw SearchError.unsortedInput }
    guard idxRange.upperBound > idxRange.lowerBound else { throw SearchError.searchKeyNotPresent }

    let midIdx = idxRange.lowerBound + (idxRange.upperBound - idxRange.lowerBound) / 2

    switch midIdx {
    case let i where sortedCollection[i] > searchKey:
        return try myBinarySearch(sortedCollection, searchKey: searchKey, idxRange: idxRange.lowerBound..<midIdx)
    case let i where sortedCollection[i] < searchKey:
        return try myBinarySearch(sortedCollection, searchKey: searchKey, idxRange: (midIdx + 1)..<idxRange.upperBound)
    default:
        return midIdx
    }
    
}

// An unsorted array of numbers
let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]

// Binary search requires that the array is sorted from low to high
let sorted = numbers.sorted()

do {
    // Using recursive solution
    try myBinarySearch(sorted, searchKey: 2, idxRange: 0 ..< sorted.count)   // gives 0
    try myBinarySearch(sorted, searchKey: 67, idxRange: 0 ..< sorted.count)  // gives 18
    try myBinarySearch(sorted, searchKey: 43, idxRange: 0 ..< sorted.count)  // gives 13
    try myBinarySearch(sorted, searchKey: 42, idxRange: 0 ..< sorted.count)  // throws searchKeyNotPresent error

}
catch {
    print("error \(error)")
}

