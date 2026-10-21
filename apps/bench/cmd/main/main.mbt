///|
fn main {
  println("DataVerse Benchmark Tool v0.1.0-dev")
  println("====================================")
  println("")
  let n = 100000
  let data = Array::make(n, 0.0)
  for i in 0..<n {
    data[i] = i.to_double()
  }
  let start_mean = @_common.mean(data)
  let start_std = @_common.std(data)
  let start_min = @_common.min(data)
  let start_max = @_common.max(data)
  println("Benchmark: Array[Double] with \{n} elements")
  println("  mean = \{start_mean}")
  println("  std  = \{start_std}")
  println("  min  = \{start_min}")
  println("  max  = \{start_max}")
  println("")
  let sorted = @_common.sort(data)
  println("Sort benchmark completed: \{sorted.length()} elements sorted")
  let s = @_common.sum(sorted)
  println("Sum of sorted: \{s}")
}
