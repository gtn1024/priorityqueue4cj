package priorityqueue4cj

import std.unittest.*
import std.unittest.testmacro.*

class Node <: Comparable<Node> {
    let value: Int64

    public init(value: Int64) {
        this.value = value
    }

    public func compare(other: Node) {
        if (this.value < other.value) {
            return Ordering.LT
        } else if (this.value > other.value) {
            return Ordering.GT
        } else {
            return Ordering.EQ
        }
    }
}

@Test
func test_push() {
    let pq = PriorityQueue<Node>.create<Node>()
    pq.push(Node(1))
    pq.push(Node(2))
    pq.push(Node(3))

    @Expect(pq.size, 3)
}
