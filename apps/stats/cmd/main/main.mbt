fn main {
  println("DataVerse Statistical Analysis Tool v0.1.0-dev")
  println("================================================")
  println("")
  let datasets = [
    ([1.0, 2.0, 3.0, 4.0, 5.0], "uniform 1-5"),
    ([10.0, 20.0, 30.0, 40.0, 50.0], "uniform 10-50"),
    ([1.0, 1.0, 1.0, 1.0, 1.0], "constant"),
    ([-2.0, -1.0, 0.0, 1.0, 2.0], "centered"),
    ([100.0, 105.0, 98.0, 103.0, 101.0], "near 100"),
  ]
  for (data, name) in datasets {
    println("Dataset: \{name}")
    println("  n        = \{data.length()}")
    println("  sum      = \{@_common.sum(data)}")
    println("  mean     = \{@_common.mean(data)}")
    println("  min      = \{@_common.min(data)}")
    println("  max      = \{@_common.max(data)}")
    println("  range    = \{@_common.max(data) - @_common.min(data)}")
    println("  median   = \{@_common.median(data)}")
    println("  variance = \{@_common.variance(data)}")
    println("  std      = \{@_common.std(data)}")
    let sorted = @_common.sort(data)
    println("  sorted   = \{sorted}")
    let norm = @_common.normalize(data)
    println("  normalize= \{norm}")
    println("")
  }
  println("Cross-dataset analysis:")
  let a = [1.0, 2.0, 3.0, 4.0, 5.0]
  let b = [2.0, 4.0, 6.0, 8.0, 10.0]
  println("  cov(a, b)  = \{@_common.cov(a, b)}")
  println("  corr(a, b) = \{@_common.corr(a, b)}")
  let pred = [1.0, 2.0, 3.0]
  let labels = [1.0, 2.0, 3.0]
  println("  mse(pred, labels) = \{@_common.mse(pred, labels)}")
  println("  rmse(pred, labels) = \{@_common.rmse(pred, labels)}")
  println("  mae(pred, labels)  = \{@_common.mae(pred, labels)}")
  println("  r2(pred, labels)   = \{@_common.r2(pred, labels)}")
  println("")
  println("Done!")
}