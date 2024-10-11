package priorityqueue4cj

import std.unittest.*
import std.unittest.testmacro.*

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
}
