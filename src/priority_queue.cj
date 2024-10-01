package priorityqueue4cj

type Comparator<T> = (T, T) -> Int64

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

    public static func create<T>(): PriorityQueue<T> where T<: Comparable<T> {
        PriorityQueue<T>(DEFAULT_INITIAL_CAPACITY, None)
    }

    public static func create<T>(initialCapacity: Int64): PriorityQueue<T> where T<: Comparable<T> {
        PriorityQueue<T>(initialCapacity, None)
    }

    public static func create<T>(comparator: Comparator<T>) {
        PriorityQueue<T>(DEFAULT_INITIAL_CAPACITY, comparator)
    }

    public static func create<T>(initialCapacity: Int64, comparator: Comparator<T>) {
        PriorityQueue<T>(initialCapacity, Some(comparator))
    }

    public func push(element: T) {
        _size += 1
    }

    public func pop(): ?T {
        None
    }
}
