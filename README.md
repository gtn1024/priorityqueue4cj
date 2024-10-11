<div align="center">
  <h1>PriorityQueue4cj</h1>
</div>
<p align="center">
  <img alt="" src="https://img.shields.io/badge/cjc-v0.55.3-brightgreen" style="display: inline-block;" />
  <img alt="" src="https://github.com/gtn1024/priorityqueue4cj/actions/workflows/ci.yml/badge.svg" style="display: inline-block;" />
</p>

## 介绍 / Introduction

基于仓颉语言的优先队列实现。

PriorityQueue implementation based on cangjie.

## 安装 / Installation

```toml
# In the `dependencies` section of `cjpm.toml`
priorityqueue4cj = { git = "https://github.com/gtn1024/priorityqueue4cj.git" }
```

## 使用 / Usage

**Comparator:**

```cj
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

while (!pq.empty()) {
    println(pq.pop()) // 1, 2, 3
}
```

## QQ 群

欢迎加入 [仓颉交流群（非官方）：985038695](https://qm.qq.com/q/PcRbAUJSo0)

![qqgroup](./.github/qqgroup.jpg)
