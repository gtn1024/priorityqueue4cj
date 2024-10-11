package priorityqueue4cj

type Comparator<T> = (T, T) -> Ordering

public class PriorityQueue<T> {
    static let DEFAULT_INITIAL_CAPACITY = 11

    let comparator: ?Comparator<T>
    var queue: Array<?T>

    public prop size: Int64 {
        get() {
            _size
        }
    }
    var _size: Int64 = 0

    init(initialCapacity: Int64, comparator: ?Comparator<T>) {
        if (initialCapacity < 1) {
            throw IllegalArgumentException("Initial capacity must be greater than 0")
        }
        this.queue = Array<?T>(initialCapacity, repeat: None)
        this.comparator = comparator
    }

    public static func create<T>(): PriorityQueue<T> where T <: Comparable<T> {
        PriorityQueue<T>(DEFAULT_INITIAL_CAPACITY, None)
    }

    public static func create<T>(initialCapacity: Int64): PriorityQueue<T> where T <: Comparable<T> {
        PriorityQueue<T>(initialCapacity, None)
    }

    public static func create<T>(comparator: Comparator<T>) {
        PriorityQueue<T>(DEFAULT_INITIAL_CAPACITY, comparator)
    }

    public static func create<T>(initialCapacity: Int64, comparator: Comparator<T>) {
        PriorityQueue<T>(initialCapacity, Some(comparator))
    }

    func grow() {
        let oldCapacity = queue.size
        var newCapacity = oldCapacity + if (oldCapacity < 64) {
            oldCapacity + 2
        } else {
            oldCapacity >> 1
        }
        if (newCapacity < 0) {
            newCapacity = Int64.Max
        }
        let newQueue = Array(newCapacity, repeat: None<T>)
        queue.copyTo(newQueue)
        this.queue = newQueue
    }

    public func empty() {
        _size == 0
    }

    public func top() {
        queue[0]
    }

    public func push(element: T) {
        let i = this._size
        if (i >= queue.size) {
            grow()
        }
        shiftUp(i, element)
        this._size = i + 1
    }

    func shiftUp(k: Int64, x: T) {
        if (let Some(cmp) <- comparator) {
            shiftUpComparator(k, x, cmp)
        } else {
            shiftUpComparable(k, x)
        }
    }

    func shiftUpComparator(index: Int64, element: T, comparator: Comparator<T>) {
        var currentIndex = index
        while (currentIndex > 0) {
            let parentIndex: Int64 = (currentIndex - 1) >> 1
            let parentElement = queue[parentIndex].getOrThrow()
            if (comparator(element, parentElement) == LT) {
                break
            }
            queue[currentIndex] = parentElement
            currentIndex = parentIndex
        }
        queue[currentIndex] = element
    }

    func shiftUpComparable(index: Int64, element: T) {
        var currentIndex = index
        let newElement = (element as Comparable<T>).getOrThrow()
        while (currentIndex > 0) {
            let parentIndex: Int64 = (currentIndex - 1) >> 1
            let parentElement = queue[parentIndex].getOrThrow()
            if (newElement.compare(parentElement) == LT) {
                break
            }
            queue[currentIndex] = parentElement
            currentIndex = parentIndex
        }
        queue[currentIndex] = element
    }

    public func pop() {
        let result = queue[0]

        if (result.isSome()) {
            _size -= 1
            let n = _size
            let x = queue[n].getOrThrow()
            queue[n] = None

            if (n > 0) {
                if (let Some(cmp) <- comparator) {
                    shiftDownComparator(0, x, n, cmp)
                } else {
                    shiftDownComparable(0, x, n)
                }
            }
        }

        result
    }

    func shiftDownComparator(startIndex: Int64, element: T, heapSize: Int64, comparator: Comparator<T>) {
        var currentIndex = startIndex
        let lastParentIndex = heapSize >> 1
        while (currentIndex < lastParentIndex) {
            var childIndex = (currentIndex << 1) + 1
            var childElement = queue[childIndex].getOrThrow()
            let rightChildIndex = childIndex + 1
            if (rightChildIndex < heapSize && comparator(childElement, queue[rightChildIndex].getOrThrow()) == LT) {
                childIndex = rightChildIndex
                childElement = queue[childIndex].getOrThrow()
            }
            if (comparator(element, childElement) != LT) {
                break
            }
            queue[currentIndex] = childElement
            currentIndex = childIndex
        }
        queue[currentIndex] = element
    }

    func shiftDownComparable(startIndex: Int64, element: T, heapSize: Int64) {
        var currentIndex = startIndex
        let elementToInsert = (element as Comparable<T>).getOrThrow()
        let lastParentIndex = heapSize >> 1
        while (currentIndex < lastParentIndex) {
            var childIndex = (currentIndex << 1) + 1
            var childElement = queue[childIndex].getOrThrow()
            let rightChildIndex = childIndex + 1
            if (rightChildIndex < heapSize &&
                (childElement as Comparable<T>).getOrThrow().compare(queue[rightChildIndex].getOrThrow()) == LT) {
                childIndex = rightChildIndex
                childElement = queue[childIndex].getOrThrow()
            }
            if (elementToInsert.compare(childElement) != LT) {
                break
            }
            queue[currentIndex] = childElement
            currentIndex = childIndex
        }
        queue[currentIndex] = (elementToInsert as T)
    }

    public func clear() {
        for (i in 0.._size) {
            queue[i] = None
        }
        _size = 0
    }
}
