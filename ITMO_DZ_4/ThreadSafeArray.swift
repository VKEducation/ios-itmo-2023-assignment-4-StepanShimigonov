import Foundation

class ThreadSafeArray<T>  {
    private var array: [T] = []
    private let rwlock = RWLock()
    
    func index(after i: Index) -> Index {
        rwlock.readLock()
        defer { rwlock.unlock() }
        return array.index(after: i)
    }
    
    func append(_ elem: Element) {
        rwlock.writeLock()
        defer { rwlock.unlock() }
        array.append(elem)
    }
    
    func remove(at: Int) {
        rwlock.writeLock()
        defer { rwlock.unlock() }
        array.remove(at: at)
    }
    
    func toString() -> String {
        rwlock.readLock()
        defer { rwlock.unlock() }
        return "\(array)"
    }
    
    func sort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        array.sort(by: areInIncreasingOrder)
    }
}

extension ThreadSafeArray: RandomAccessCollection {
    typealias Index = Int
    typealias Element = T

    var startIndex: Index {
        rwlock.readLock()
        defer { rwlock.unlock() }
        return array.startIndex
    }
    
    var endIndex: Index {
        rwlock.readLock()
        defer { rwlock.unlock() }
        return array.endIndex
    }

    subscript(index: Index) -> Element {
        get {
            rwlock.readLock()
            defer { rwlock.unlock() }
            return array[index]
        }
        
        set {
            rwlock.writeLock()
            defer { rwlock.unlock() }
            array[index] = newValue
        }
    }
}
