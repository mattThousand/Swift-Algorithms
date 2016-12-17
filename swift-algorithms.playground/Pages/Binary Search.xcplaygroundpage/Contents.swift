/**
 Binary Search
 
 Recursively splits the array in half until the value is found.
 
 If there is more than one occurrence of the search key in the array, then
 there is no guarantee which one it finds.
 
 Note: The array must be sorted!
 **/

import Foundation

// The recursive version of binary search.

public func binarySearch<T: Comparable>(_ sortedCollection: [T], searchKey: T, idxRange: Range<Index>) throws -> Index? {

    // Throw an error if the collection is not sorted
    guard sortedCollection.isSorted else { throw SearchError.unsortedInput }

    // Throw an error if the search key is not present in the collection
    guard idxRange.upperBound > idxRange.lowerBound else { throw SearchError.searchKeyNotPresent }

    // Calculate the index in the middle of the sub-collection
    let midIdx = idxRange.lowerBound + (idxRange.upperBound - idxRange.lowerBound) / 2

    switch midIdx {
    case let i where sortedCollection[i] > searchKey:
        // If the element in the middle of the sub-collection is greater than the search key,
        // call binarySearch on the sub-collection to the left of the middle index
        return try binarySearch(sortedCollection, searchKey: searchKey, idxRange: idxRange.lowerBound..<midIdx)
    case let i where sortedCollection[i] < searchKey:
        // If the element in the middle of the sub-collection is less than the search key,
        // call binarySearch on the sub-collection to the right of the middle index
        return try binarySearch(sortedCollection, searchKey: searchKey, idxRange: (midIdx + 1)..<idxRange.upperBound)
    default:
        // If the element in the middle of the sub-collection is equal to the search key, return the index
        return midIdx
    }
    
}


// Utilities
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

// An unsorted array of numbers
let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]

// Binary search requires that the array is sorted from low to high
let sorted = numbers.sorted()

do {
    // Using recursive solution
    try binarySearch(sorted, searchKey: 2, idxRange: 0 ..< sorted.count)   // gives 0
    try binarySearch(sorted, searchKey: 67, idxRange: 0 ..< sorted.count)  // gives 18
    try binarySearch(sorted, searchKey: 43, idxRange: 0 ..< sorted.count)  // gives 13
    try binarySearch(sorted, searchKey: 42, idxRange: 0 ..< sorted.count)  // throws searchKeyNotPresent error

}
catch {
    print("error \(error)")
}

