///===
/// extcore/ds_heap_binomial

pub(all) struct DsheapbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_binomial_make_point(x : Double, y : Double) -> DsheapbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_binomial_make_point3(x : Double, y : Double, z : Double) -> DsheapbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapbinomialPoint::x(self : DsheapbinomialPoint) -> Double { self.x }

pub fn DsheapbinomialPoint::y(self : DsheapbinomialPoint) -> Double { self.y }

pub fn DsheapbinomialPoint::z(self : DsheapbinomialPoint) -> Double { self.z }

pub fn DsheapbinomialPoint::label(self : DsheapbinomialPoint) -> Int { self.label }

pub fn DsheapbinomialPoint::dist(self : DsheapbinomialPoint, other : DsheapbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapbinomialPoint::add(self : DsheapbinomialPoint, other : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapbinomialPoint::sub(self : DsheapbinomialPoint, other : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapbinomialPoint::scale(self : DsheapbinomialPoint, s : Double) -> DsheapbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapbinomialPoint::dot(self : DsheapbinomialPoint, other : DsheapbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapbinomialPoint::cross(self : DsheapbinomialPoint, other : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapbinomialPoint::norm(self : DsheapbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapbinomialPoint::normalize(self : DsheapbinomialPoint) -> DsheapbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapbinomialPoint::negate(self : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapbinomialPoint::mid(self : DsheapbinomialPoint, other : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapbinomialPoint::lerp(self : DsheapbinomialPoint, other : DsheapbinomialPoint, t : Double) -> DsheapbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapbinomialPoint::to_string(self : DsheapbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_binomial_make_series(vals : Array[Double], name : String) -> DsheapbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapbinomialSeries::len(self : DsheapbinomialSeries) -> Int { self.vals.length() }

pub fn DsheapbinomialSeries::sum(self : DsheapbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapbinomialSeries::mean(self : DsheapbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapbinomialSeries::min(self : DsheapbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapbinomialSeries::max(self : DsheapbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapbinomialSeries::range(self : DsheapbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapbinomialSeries::variance(self : DsheapbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapbinomialSeries::std(self : DsheapbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapbinomialSeries::median(self : DsheapbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapbinomialSeries::scale(self : DsheapbinomialSeries, f : Double) -> DsheapbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapbinomialSeries::add(self : DsheapbinomialSeries, other : DsheapbinomialSeries) -> DsheapbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapbinomialSeries::sub(self : DsheapbinomialSeries, other : DsheapbinomialSeries) -> DsheapbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapbinomialSeries::normalize(self : DsheapbinomialSeries) -> DsheapbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapbinomialSeries::cumsum(self : DsheapbinomialSeries) -> DsheapbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapbinomialSeries::to_string(self : DsheapbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_binomial_matrix_identity(n : Int) -> DsheapbinomialMatrix {
  let m = ds_heap_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapbinomialMatrix::get(self : DsheapbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapbinomialMatrix::transpose(self : DsheapbinomialMatrix) -> DsheapbinomialMatrix {
  let result = ds_heap_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapbinomialMatrix::add(self : DsheapbinomialMatrix, other : DsheapbinomialMatrix) -> DsheapbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapbinomialMatrix::scale(self : DsheapbinomialMatrix, s : Double) -> DsheapbinomialMatrix {
  let result = ds_heap_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapbinomialMatrix::multiply(self : DsheapbinomialMatrix, other : DsheapbinomialMatrix) -> DsheapbinomialMatrix {
  if self.cols != other.rows { return ds_heap_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapbinomialMatrix::trace(self : DsheapbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapbinomialMatrix::det(self : DsheapbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapbinomialMatrix::norm(self : DsheapbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapbinomialMatrix::to_string(self : DsheapbinomialMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsheapbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_binomial_make_vector(comps : Array[Double]) -> DsheapbinomialVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_binomial_vector_zero(dim : Int) -> DsheapbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapbinomialVector::add(self : DsheapbinomialVector, other : DsheapbinomialVector) -> DsheapbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapbinomialVector::sub(self : DsheapbinomialVector, other : DsheapbinomialVector) -> DsheapbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapbinomialVector::scale(self : DsheapbinomialVector, s : Double) -> DsheapbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapbinomialVector::dot(self : DsheapbinomialVector, other : DsheapbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapbinomialVector::norm(self : DsheapbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapbinomialVector::normalize(self : DsheapbinomialVector) -> DsheapbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapbinomialVector::dist(self : DsheapbinomialVector, other : DsheapbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapbinomialVector::to_string(self : DsheapbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_binomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_binomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_binomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_binomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_binomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_binomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_binomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_binomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_binomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_binomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_binomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_binomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_binomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_binomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_binomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_binomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_binomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_binomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_binomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_frame_make(size : Int) -> DsheapbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialFrame::len(self : DsheapbinomialFrame) -> Int { self.size }

pub fn DsheapbinomialFrame::get(self : DsheapbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialFrame::set(self : DsheapbinomialFrame, i : Int, v : Double) -> DsheapbinomialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialFrame::sum(self : DsheapbinomialFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialFrame::mean(self : DsheapbinomialFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialFrame::scale(self : DsheapbinomialFrame, f : Double) -> DsheapbinomialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialFrame::add(self : DsheapbinomialFrame, other : DsheapbinomialFrame) -> DsheapbinomialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialFrame::copy(self : DsheapbinomialFrame) -> DsheapbinomialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialFrame::fill(self : DsheapbinomialFrame, v : Double) -> DsheapbinomialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialFrame::min(self : DsheapbinomialFrame) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialFrame::max(self : DsheapbinomialFrame) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialFrame::to_string(self : DsheapbinomialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_table_make(size : Int) -> DsheapbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialTable::len(self : DsheapbinomialTable) -> Int { self.size }

pub fn DsheapbinomialTable::get(self : DsheapbinomialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialTable::set(self : DsheapbinomialTable, i : Int, v : Double) -> DsheapbinomialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialTable::sum(self : DsheapbinomialTable) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialTable::mean(self : DsheapbinomialTable) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialTable::scale(self : DsheapbinomialTable, f : Double) -> DsheapbinomialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialTable::add(self : DsheapbinomialTable, other : DsheapbinomialTable) -> DsheapbinomialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialTable::copy(self : DsheapbinomialTable) -> DsheapbinomialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialTable::fill(self : DsheapbinomialTable, v : Double) -> DsheapbinomialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialTable::min(self : DsheapbinomialTable) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialTable::max(self : DsheapbinomialTable) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialTable::to_string(self : DsheapbinomialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_graphn_make(size : Int) -> DsheapbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialGraphN::len(self : DsheapbinomialGraphN) -> Int { self.size }

pub fn DsheapbinomialGraphN::get(self : DsheapbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialGraphN::set(self : DsheapbinomialGraphN, i : Int, v : Double) -> DsheapbinomialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialGraphN::sum(self : DsheapbinomialGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialGraphN::mean(self : DsheapbinomialGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialGraphN::scale(self : DsheapbinomialGraphN, f : Double) -> DsheapbinomialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialGraphN::add(self : DsheapbinomialGraphN, other : DsheapbinomialGraphN) -> DsheapbinomialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialGraphN::copy(self : DsheapbinomialGraphN) -> DsheapbinomialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialGraphN::fill(self : DsheapbinomialGraphN, v : Double) -> DsheapbinomialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialGraphN::min(self : DsheapbinomialGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialGraphN::max(self : DsheapbinomialGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialGraphN::to_string(self : DsheapbinomialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_node_make(size : Int) -> DsheapbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialNode::len(self : DsheapbinomialNode) -> Int { self.size }

pub fn DsheapbinomialNode::get(self : DsheapbinomialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialNode::set(self : DsheapbinomialNode, i : Int, v : Double) -> DsheapbinomialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialNode::sum(self : DsheapbinomialNode) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialNode::mean(self : DsheapbinomialNode) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialNode::scale(self : DsheapbinomialNode, f : Double) -> DsheapbinomialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialNode::add(self : DsheapbinomialNode, other : DsheapbinomialNode) -> DsheapbinomialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialNode::copy(self : DsheapbinomialNode) -> DsheapbinomialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialNode::fill(self : DsheapbinomialNode, v : Double) -> DsheapbinomialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialNode::min(self : DsheapbinomialNode) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialNode::max(self : DsheapbinomialNode) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialNode::to_string(self : DsheapbinomialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_edge_make(size : Int) -> DsheapbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialEdge::len(self : DsheapbinomialEdge) -> Int { self.size }

pub fn DsheapbinomialEdge::get(self : DsheapbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialEdge::set(self : DsheapbinomialEdge, i : Int, v : Double) -> DsheapbinomialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialEdge::sum(self : DsheapbinomialEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialEdge::mean(self : DsheapbinomialEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialEdge::scale(self : DsheapbinomialEdge, f : Double) -> DsheapbinomialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialEdge::add(self : DsheapbinomialEdge, other : DsheapbinomialEdge) -> DsheapbinomialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialEdge::copy(self : DsheapbinomialEdge) -> DsheapbinomialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialEdge::fill(self : DsheapbinomialEdge, v : Double) -> DsheapbinomialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialEdge::min(self : DsheapbinomialEdge) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialEdge::max(self : DsheapbinomialEdge) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialEdge::to_string(self : DsheapbinomialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_path_make(size : Int) -> DsheapbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialPath::len(self : DsheapbinomialPath) -> Int { self.size }

pub fn DsheapbinomialPath::get(self : DsheapbinomialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialPath::set(self : DsheapbinomialPath, i : Int, v : Double) -> DsheapbinomialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialPath::sum(self : DsheapbinomialPath) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialPath::mean(self : DsheapbinomialPath) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialPath::scale(self : DsheapbinomialPath, f : Double) -> DsheapbinomialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialPath::add(self : DsheapbinomialPath, other : DsheapbinomialPath) -> DsheapbinomialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialPath::copy(self : DsheapbinomialPath) -> DsheapbinomialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialPath::fill(self : DsheapbinomialPath, v : Double) -> DsheapbinomialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialPath::min(self : DsheapbinomialPath) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialPath::max(self : DsheapbinomialPath) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialPath::to_string(self : DsheapbinomialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_cluster_make(size : Int) -> DsheapbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialCluster::len(self : DsheapbinomialCluster) -> Int { self.size }

pub fn DsheapbinomialCluster::get(self : DsheapbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialCluster::set(self : DsheapbinomialCluster, i : Int, v : Double) -> DsheapbinomialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCluster::sum(self : DsheapbinomialCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialCluster::mean(self : DsheapbinomialCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialCluster::scale(self : DsheapbinomialCluster, f : Double) -> DsheapbinomialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCluster::add(self : DsheapbinomialCluster, other : DsheapbinomialCluster) -> DsheapbinomialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialCluster::copy(self : DsheapbinomialCluster) -> DsheapbinomialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCluster::fill(self : DsheapbinomialCluster, v : Double) -> DsheapbinomialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCluster::min(self : DsheapbinomialCluster) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialCluster::max(self : DsheapbinomialCluster) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialCluster::to_string(self : DsheapbinomialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_model_make(size : Int) -> DsheapbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialModel::len(self : DsheapbinomialModel) -> Int { self.size }

pub fn DsheapbinomialModel::get(self : DsheapbinomialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialModel::set(self : DsheapbinomialModel, i : Int, v : Double) -> DsheapbinomialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialModel::sum(self : DsheapbinomialModel) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialModel::mean(self : DsheapbinomialModel) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialModel::scale(self : DsheapbinomialModel, f : Double) -> DsheapbinomialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialModel::add(self : DsheapbinomialModel, other : DsheapbinomialModel) -> DsheapbinomialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialModel::copy(self : DsheapbinomialModel) -> DsheapbinomialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialModel::fill(self : DsheapbinomialModel, v : Double) -> DsheapbinomialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialModel::min(self : DsheapbinomialModel) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialModel::max(self : DsheapbinomialModel) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialModel::to_string(self : DsheapbinomialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_layer_make(size : Int) -> DsheapbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialLayer::len(self : DsheapbinomialLayer) -> Int { self.size }

pub fn DsheapbinomialLayer::get(self : DsheapbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialLayer::set(self : DsheapbinomialLayer, i : Int, v : Double) -> DsheapbinomialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialLayer::sum(self : DsheapbinomialLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialLayer::mean(self : DsheapbinomialLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialLayer::scale(self : DsheapbinomialLayer, f : Double) -> DsheapbinomialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialLayer::add(self : DsheapbinomialLayer, other : DsheapbinomialLayer) -> DsheapbinomialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialLayer::copy(self : DsheapbinomialLayer) -> DsheapbinomialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialLayer::fill(self : DsheapbinomialLayer, v : Double) -> DsheapbinomialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialLayer::min(self : DsheapbinomialLayer) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialLayer::max(self : DsheapbinomialLayer) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialLayer::to_string(self : DsheapbinomialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_buffer_make(size : Int) -> DsheapbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialBuffer::len(self : DsheapbinomialBuffer) -> Int { self.size }

pub fn DsheapbinomialBuffer::get(self : DsheapbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialBuffer::set(self : DsheapbinomialBuffer, i : Int, v : Double) -> DsheapbinomialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialBuffer::sum(self : DsheapbinomialBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialBuffer::mean(self : DsheapbinomialBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialBuffer::scale(self : DsheapbinomialBuffer, f : Double) -> DsheapbinomialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialBuffer::add(self : DsheapbinomialBuffer, other : DsheapbinomialBuffer) -> DsheapbinomialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialBuffer::copy(self : DsheapbinomialBuffer) -> DsheapbinomialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialBuffer::fill(self : DsheapbinomialBuffer, v : Double) -> DsheapbinomialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialBuffer::min(self : DsheapbinomialBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialBuffer::max(self : DsheapbinomialBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialBuffer::to_string(self : DsheapbinomialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_cursor_make(size : Int) -> DsheapbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialCursor::len(self : DsheapbinomialCursor) -> Int { self.size }

pub fn DsheapbinomialCursor::get(self : DsheapbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialCursor::set(self : DsheapbinomialCursor, i : Int, v : Double) -> DsheapbinomialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCursor::sum(self : DsheapbinomialCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialCursor::mean(self : DsheapbinomialCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialCursor::scale(self : DsheapbinomialCursor, f : Double) -> DsheapbinomialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCursor::add(self : DsheapbinomialCursor, other : DsheapbinomialCursor) -> DsheapbinomialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialCursor::copy(self : DsheapbinomialCursor) -> DsheapbinomialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCursor::fill(self : DsheapbinomialCursor, v : Double) -> DsheapbinomialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialCursor::min(self : DsheapbinomialCursor) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialCursor::max(self : DsheapbinomialCursor) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialCursor::to_string(self : DsheapbinomialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_view_make(size : Int) -> DsheapbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialView::len(self : DsheapbinomialView) -> Int { self.size }

pub fn DsheapbinomialView::get(self : DsheapbinomialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialView::set(self : DsheapbinomialView, i : Int, v : Double) -> DsheapbinomialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialView::sum(self : DsheapbinomialView) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialView::mean(self : DsheapbinomialView) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialView::scale(self : DsheapbinomialView, f : Double) -> DsheapbinomialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialView::add(self : DsheapbinomialView, other : DsheapbinomialView) -> DsheapbinomialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialView::copy(self : DsheapbinomialView) -> DsheapbinomialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialView::fill(self : DsheapbinomialView, v : Double) -> DsheapbinomialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialView::min(self : DsheapbinomialView) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialView::max(self : DsheapbinomialView) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialView::to_string(self : DsheapbinomialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_range_make(size : Int) -> DsheapbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialRange::len(self : DsheapbinomialRange) -> Int { self.size }

pub fn DsheapbinomialRange::get(self : DsheapbinomialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialRange::set(self : DsheapbinomialRange, i : Int, v : Double) -> DsheapbinomialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialRange::sum(self : DsheapbinomialRange) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialRange::mean(self : DsheapbinomialRange) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialRange::scale(self : DsheapbinomialRange, f : Double) -> DsheapbinomialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialRange::add(self : DsheapbinomialRange, other : DsheapbinomialRange) -> DsheapbinomialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialRange::copy(self : DsheapbinomialRange) -> DsheapbinomialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialRange::fill(self : DsheapbinomialRange, v : Double) -> DsheapbinomialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialRange::min(self : DsheapbinomialRange) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialRange::max(self : DsheapbinomialRange) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialRange::to_string(self : DsheapbinomialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_slice_make(size : Int) -> DsheapbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinomialSlice::len(self : DsheapbinomialSlice) -> Int { self.size }

pub fn DsheapbinomialSlice::get(self : DsheapbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinomialSlice::set(self : DsheapbinomialSlice, i : Int, v : Double) -> DsheapbinomialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinomialSlice::sum(self : DsheapbinomialSlice) -> Double { @_common.sum(self.data) }

pub fn DsheapbinomialSlice::mean(self : DsheapbinomialSlice) -> Double { @_common.mean(self.data) }

pub fn DsheapbinomialSlice::scale(self : DsheapbinomialSlice, f : Double) -> DsheapbinomialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialSlice::add(self : DsheapbinomialSlice, other : DsheapbinomialSlice) -> DsheapbinomialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinomialSlice::copy(self : DsheapbinomialSlice) -> DsheapbinomialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialSlice::fill(self : DsheapbinomialSlice, v : Double) -> DsheapbinomialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinomialSlice::min(self : DsheapbinomialSlice) -> Double { @_common.min(self.data) }

pub fn DsheapbinomialSlice::max(self : DsheapbinomialSlice) -> Double { @_common.max(self.data) }

pub fn DsheapbinomialSlice::to_string(self : DsheapbinomialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

