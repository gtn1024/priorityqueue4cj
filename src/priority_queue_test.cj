package priorityqueue4cj

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import std.random.*

@Test
class PriorityQueueTest {
    @TestCase
    func test_push() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        pq.push(Int64(1))
        pq.push(Int64(2))
        pq.push(Int64(3))

        @Expect(pq.size, 3)
    }

    @TestCase
    func test_push_top() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        pq.push(1)
        @Expect(pq.top(), Some(1))
        pq.push(2)
        @Expect(pq.top(), Some(2))
        pq.push(3)
        @Expect(pq.top(), Some(3))
        pq.push(0)
        @Expect(pq.top(), Some(3))
        pq.push(10)
        @Expect(pq.top(), Some(10))
    }

    @TestCase
    func test_pop() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        pq.push(1)
        pq.push(2)
        pq.push(3)
        pq.push(0)
        pq.push(10)

        @Expect(pq.pop(), Some(10))
        @Expect(pq.pop(), Some(3))
        @Expect(pq.pop(), Some(2))
        @Expect(pq.pop(), Some(1))
        @Expect(pq.pop(), Some(0))
    }

    @TestCase
    func test_empty() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        @Expect(pq.empty())
        pq.push(1)
        @Expect(pq.empty(), false)
        pq.pop()
        @Expect(pq.empty())
    }

    @TestCase
    func test_clear() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        pq.push(1)
        pq.push(2)
        pq.push(3)
        pq.clear()
        @Expect(pq.size, 0)
        @Expect(pq.empty())
    }

    @TestCase
    func test_push_pop() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        pq.push(5)
        pq.push(3)
        pq.push(7)
        pq.push(1)
        pq.push(9)
        @Expect(pq.pop(), Some(9))
        @Expect(pq.pop(), Some(7))
        @Expect(pq.pop(), Some(5))
        @Expect(pq.pop(), Some(3))
        @Expect(pq.pop(), Some(1))
        @Expect(pq.empty())
    }

    @TestCase
    func test_random() {
        let pq = PriorityQueue<Int64>.create<Int64>()
        let list = ArrayList<Int64>()
        for (i in 0..10000) {
            list.append(i)
        }
        list.shuffle()
        for (i in 0..10000) {
            pq.push(list[i])
        }
        for (i in 0..10000) {
            @Expect(pq.pop(), Some(9999 - i))
        }
    }
}

@Test
class PriorityQueueComparatorTest {
    @TestCase
    func test_push_pop() {
        let pq = PriorityQueue<Int64>.create<Int64>({ a, b =>
            if (a < b) {
                Ordering.GT
            } else if (a > b) {
                Ordering.LT
            } else {
                Ordering.EQ
            }
        })
        pq.push(1)
        pq.push(2)
        pq.push(3)

        @Expect(pq.size, 3)

        @Expect(pq.pop(), Some(1))
        @Expect(pq.pop(), Some(2))
        @Expect(pq.pop(), Some(3))
        @Expect(pq.pop(), None)
    }

    @TestCase
    func test_random() {
        let pq = PriorityQueue<Int64>.create<Int64>({ a, b =>
            if (a < b) {
                Ordering.GT
            } else if (a > b) {
                Ordering.LT
            } else {
                Ordering.EQ
            }
        })
        let list = ArrayList<Int64>()
        for (i in 0..10000) {
            list.append(i)
        }
        list.shuffle()
        for (i in 0..10000) {
            pq.push(list[i])
        }
        for (i in 0..10000) {
            @Expect(pq.pop(), Some(i))
        }
    }
}

extend ArrayList<Int64> {
    func shuffle() {
        let random = Random()
        for (i in 0..size) {
            let j = i + random.nextInt64(size - i)
            let tmp = this[i]
            this[i] = this[j]
            this[j] = tmp
        }
    }
}
