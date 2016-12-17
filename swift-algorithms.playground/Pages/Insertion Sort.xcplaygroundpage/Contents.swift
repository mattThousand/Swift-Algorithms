/**
 Insertion Sort

 Insertion sort iterates, consuming one input element each repetition,
 and growing a sorted output list. Each iteration, insertion sort removes 
 one element from the input data,finds the location it belongs within the 
 sorted list, and inserts it there. It repeats until no input elements remain.
 
 Performance:
 - O(n^2) <- worst case
 
 **/

func insertionSort<T: Comparable>(_ collection: [T]) -> [T] {

    // The collection is already sorted if it's empty, so just return it
    guard collection.count > 0 else {
        return collection
    }

    // We need to copy the collection passed in, because it's immutable
    var collectionCopy = collection

    // Iterate through the collection
    for idx in 1..<collection.count {

        // compare 2 adjacent elements, if they are out of order, swap them 
        // and pass the altered collection back into the insertionSort
        if collection[idx] < collection[idx - 1] {
            swap(&collectionCopy[idx], &collectionCopy[idx - 1])
            return insertionSort(collectionCopy)
        }
    }

    return collectionCopy
}
