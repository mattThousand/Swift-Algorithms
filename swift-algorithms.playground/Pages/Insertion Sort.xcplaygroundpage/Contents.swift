func insertionSort<T: Comparable>(_ collection: [T]) -> [T] {

    guard collection.count > 0 else {
        return collection
    }

    var collectionCopy = collection

    for idx in 1..<collection.count {
        if collection[idx] < collection[idx - 1] {
            swap(&collectionCopy[idx], &collectionCopy[idx - 1])
            return insertionSort(collectionCopy)
        }
    }

    return collectionCopy
}
