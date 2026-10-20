///===
/// extcore/ds_heap_fibonacci

pub(all) struct DsheapfibonacciPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_fibonacci_make_point(x : Double, y : Double) -> DsheapfibonacciPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_fibonacci_make_point3(x : Double, y : Double, z : Double) -> DsheapfibonacciPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapfibonacciPoint::x(self : DsheapfibonacciPoint) -> Double { self.x }

pub fn DsheapfibonacciPoint::y(self : DsheapfibonacciPoint) -> Double { self.y }

pub fn DsheapfibonacciPoint::z(self : DsheapfibonacciPoint) -> Double { self.z }

pub fn DsheapfibonacciPoint::label(self : DsheapfibonacciPoint) -> Int { self.label }

pub fn DsheapfibonacciPoint::dist(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapfibonacciPoint::add(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapfibonacciPoint::sub(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapfibonacciPoint::scale(self : DsheapfibonacciPoint, s : Double) -> DsheapfibonacciPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapfibonacciPoint::dot(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapfibonacciPoint::cross(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapfibonacciPoint::norm(self : DsheapfibonacciPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapfibonacciPoint::normalize(self : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapfibonacciPoint::negate(self : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapfibonacciPoint::mid(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapfibonacciPoint::lerp(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint, t : Double) -> DsheapfibonacciPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapfibonacciPoint::to_string(self : DsheapfibonacciPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapfibonacciSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_fibonacci_make_series(vals : Array[Double], name : String) -> DsheapfibonacciSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapfibonacciSeries::len(self : DsheapfibonacciSeries) -> Int { self.vals.length() }

pub fn DsheapfibonacciSeries::sum(self : DsheapfibonacciSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapfibonacciSeries::mean(self : DsheapfibonacciSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapfibonacciSeries::min(self : DsheapfibonacciSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapfibonacciSeries::max(self : DsheapfibonacciSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapfibonacciSeries::range(self : DsheapfibonacciSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapfibonacciSeries::variance(self : DsheapfibonacciSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapfibonacciSeries::std(self : DsheapfibonacciSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapfibonacciSeries::median(self : DsheapfibonacciSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapfibonacciSeries::scale(self : DsheapfibonacciSeries, f : Double) -> DsheapfibonacciSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapfibonacciSeries::add(self : DsheapfibonacciSeries, other : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapfibonacciSeries::sub(self : DsheapfibonacciSeries, other : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapfibonacciSeries::normalize(self : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapfibonacciSeries::cumsum(self : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapfibonacciSeries::to_string(self : DsheapfibonacciSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapfibonacciMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_fibonacci_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapfibonacciMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_fibonacci_matrix_identity(n : Int) -> DsheapfibonacciMatrix {
  let m = ds_heap_fibonacci_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapfibonacciMatrix::get(self : DsheapfibonacciMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapfibonacciMatrix::transpose(self : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapfibonacciMatrix::add(self : DsheapfibonacciMatrix, other : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_fibonacci_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapfibonacciMatrix::scale(self : DsheapfibonacciMatrix, s : Double) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapfibonacciMatrix::multiply(self : DsheapfibonacciMatrix, other : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if self.cols != other.rows { return ds_heap_fibonacci_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_fibonacci_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapfibonacciMatrix::trace(self : DsheapfibonacciMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapfibonacciMatrix::det(self : DsheapfibonacciMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapfibonacciMatrix::norm(self : DsheapfibonacciMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapfibonacciMatrix::to_string(self : DsheapfibonacciMatrix) -> String {
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

pub(all) struct DsheapfibonacciVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_fibonacci_make_vector(comps : Array[Double]) -> DsheapfibonacciVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_fibonacci_vector_zero(dim : Int) -> DsheapfibonacciVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapfibonacciVector::add(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapfibonacciVector::sub(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapfibonacciVector::scale(self : DsheapfibonacciVector, s : Double) -> DsheapfibonacciVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapfibonacciVector::dot(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapfibonacciVector::norm(self : DsheapfibonacciVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapfibonacciVector::normalize(self : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapfibonacciVector::dist(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapfibonacciVector::to_string(self : DsheapfibonacciVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_fibonacci_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_fibonacci_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_fibonacci_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_fibonacci_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_fibonacci_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_fibonacci_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_fibonacci_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_fibonacci_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_fibonacci_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_fibonacci_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_fibonacci_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_fibonacci_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_fibonacci_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_fibonacci_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_fibonacci_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_fibonacci_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_fibonacci_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_fibonacci_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_fibonacci_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_fibonacci_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_fibonacci_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_fibonacci_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_fibonacci_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_fibonacci_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_fibonacci_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_fibonacci_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_fibonacci_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_fibonacci_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_fibonacci_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapfibonacciFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_frame_make(size : Int) -> DsheapfibonacciFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_frame_len(s : DsheapfibonacciFrame) -> Int { s.size }

pub fn ds_heap_fibonacci_frame_get(s : DsheapfibonacciFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_frame_set(s : DsheapfibonacciFrame, i : Int, v : Double) -> DsheapfibonacciFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_sum(s : DsheapfibonacciFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_frame_mean(s : DsheapfibonacciFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_frame_scale(s : DsheapfibonacciFrame, f : Double) -> DsheapfibonacciFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_add(a : DsheapfibonacciFrame, b : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_frame_copy(s : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_fill(s : DsheapfibonacciFrame, v : Double) -> DsheapfibonacciFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_min(s : DsheapfibonacciFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_frame_max(s : DsheapfibonacciFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_frame_to_string(s : DsheapfibonacciFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_table_make(size : Int) -> DsheapfibonacciTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_table_len(s : DsheapfibonacciTable) -> Int { s.size }

pub fn ds_heap_fibonacci_table_get(s : DsheapfibonacciTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_table_set(s : DsheapfibonacciTable, i : Int, v : Double) -> DsheapfibonacciTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_sum(s : DsheapfibonacciTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_table_mean(s : DsheapfibonacciTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_table_scale(s : DsheapfibonacciTable, f : Double) -> DsheapfibonacciTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_add(a : DsheapfibonacciTable, b : DsheapfibonacciTable) -> DsheapfibonacciTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_table_copy(s : DsheapfibonacciTable) -> DsheapfibonacciTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_fill(s : DsheapfibonacciTable, v : Double) -> DsheapfibonacciTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_min(s : DsheapfibonacciTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_table_max(s : DsheapfibonacciTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_table_to_string(s : DsheapfibonacciTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_graphn_make(size : Int) -> DsheapfibonacciGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_graphn_len(s : DsheapfibonacciGraphN) -> Int { s.size }

pub fn ds_heap_fibonacci_graphn_get(s : DsheapfibonacciGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_graphn_set(s : DsheapfibonacciGraphN, i : Int, v : Double) -> DsheapfibonacciGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_sum(s : DsheapfibonacciGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_graphn_mean(s : DsheapfibonacciGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_graphn_scale(s : DsheapfibonacciGraphN, f : Double) -> DsheapfibonacciGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_add(a : DsheapfibonacciGraphN, b : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_graphn_copy(s : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_fill(s : DsheapfibonacciGraphN, v : Double) -> DsheapfibonacciGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_min(s : DsheapfibonacciGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_graphn_max(s : DsheapfibonacciGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_graphn_to_string(s : DsheapfibonacciGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_node_make(size : Int) -> DsheapfibonacciNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_node_len(s : DsheapfibonacciNode) -> Int { s.size }

pub fn ds_heap_fibonacci_node_get(s : DsheapfibonacciNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_node_set(s : DsheapfibonacciNode, i : Int, v : Double) -> DsheapfibonacciNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_sum(s : DsheapfibonacciNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_node_mean(s : DsheapfibonacciNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_node_scale(s : DsheapfibonacciNode, f : Double) -> DsheapfibonacciNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_add(a : DsheapfibonacciNode, b : DsheapfibonacciNode) -> DsheapfibonacciNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_node_copy(s : DsheapfibonacciNode) -> DsheapfibonacciNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_fill(s : DsheapfibonacciNode, v : Double) -> DsheapfibonacciNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_min(s : DsheapfibonacciNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_node_max(s : DsheapfibonacciNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_node_to_string(s : DsheapfibonacciNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_edge_make(size : Int) -> DsheapfibonacciEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_edge_len(s : DsheapfibonacciEdge) -> Int { s.size }

pub fn ds_heap_fibonacci_edge_get(s : DsheapfibonacciEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_edge_set(s : DsheapfibonacciEdge, i : Int, v : Double) -> DsheapfibonacciEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_sum(s : DsheapfibonacciEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_edge_mean(s : DsheapfibonacciEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_edge_scale(s : DsheapfibonacciEdge, f : Double) -> DsheapfibonacciEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_add(a : DsheapfibonacciEdge, b : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_edge_copy(s : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_fill(s : DsheapfibonacciEdge, v : Double) -> DsheapfibonacciEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_min(s : DsheapfibonacciEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_edge_max(s : DsheapfibonacciEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_edge_to_string(s : DsheapfibonacciEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_path_make(size : Int) -> DsheapfibonacciPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_path_len(s : DsheapfibonacciPath) -> Int { s.size }

pub fn ds_heap_fibonacci_path_get(s : DsheapfibonacciPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_path_set(s : DsheapfibonacciPath, i : Int, v : Double) -> DsheapfibonacciPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_sum(s : DsheapfibonacciPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_path_mean(s : DsheapfibonacciPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_path_scale(s : DsheapfibonacciPath, f : Double) -> DsheapfibonacciPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_add(a : DsheapfibonacciPath, b : DsheapfibonacciPath) -> DsheapfibonacciPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_path_copy(s : DsheapfibonacciPath) -> DsheapfibonacciPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_fill(s : DsheapfibonacciPath, v : Double) -> DsheapfibonacciPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_min(s : DsheapfibonacciPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_path_max(s : DsheapfibonacciPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_path_to_string(s : DsheapfibonacciPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cluster_make(size : Int) -> DsheapfibonacciCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_cluster_len(s : DsheapfibonacciCluster) -> Int { s.size }

pub fn ds_heap_fibonacci_cluster_get(s : DsheapfibonacciCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_cluster_set(s : DsheapfibonacciCluster, i : Int, v : Double) -> DsheapfibonacciCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_sum(s : DsheapfibonacciCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_cluster_mean(s : DsheapfibonacciCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_cluster_scale(s : DsheapfibonacciCluster, f : Double) -> DsheapfibonacciCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_add(a : DsheapfibonacciCluster, b : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_cluster_copy(s : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_fill(s : DsheapfibonacciCluster, v : Double) -> DsheapfibonacciCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_min(s : DsheapfibonacciCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_cluster_max(s : DsheapfibonacciCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_cluster_to_string(s : DsheapfibonacciCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_model_make(size : Int) -> DsheapfibonacciModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_model_len(s : DsheapfibonacciModel) -> Int { s.size }

pub fn ds_heap_fibonacci_model_get(s : DsheapfibonacciModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_model_set(s : DsheapfibonacciModel, i : Int, v : Double) -> DsheapfibonacciModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_sum(s : DsheapfibonacciModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_model_mean(s : DsheapfibonacciModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_model_scale(s : DsheapfibonacciModel, f : Double) -> DsheapfibonacciModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_add(a : DsheapfibonacciModel, b : DsheapfibonacciModel) -> DsheapfibonacciModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_model_copy(s : DsheapfibonacciModel) -> DsheapfibonacciModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_fill(s : DsheapfibonacciModel, v : Double) -> DsheapfibonacciModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_min(s : DsheapfibonacciModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_model_max(s : DsheapfibonacciModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_model_to_string(s : DsheapfibonacciModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_layer_make(size : Int) -> DsheapfibonacciLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_layer_len(s : DsheapfibonacciLayer) -> Int { s.size }

pub fn ds_heap_fibonacci_layer_get(s : DsheapfibonacciLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_layer_set(s : DsheapfibonacciLayer, i : Int, v : Double) -> DsheapfibonacciLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_sum(s : DsheapfibonacciLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_layer_mean(s : DsheapfibonacciLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_layer_scale(s : DsheapfibonacciLayer, f : Double) -> DsheapfibonacciLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_add(a : DsheapfibonacciLayer, b : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_layer_copy(s : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_fill(s : DsheapfibonacciLayer, v : Double) -> DsheapfibonacciLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_min(s : DsheapfibonacciLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_layer_max(s : DsheapfibonacciLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_layer_to_string(s : DsheapfibonacciLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_buffer_make(size : Int) -> DsheapfibonacciBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_buffer_len(s : DsheapfibonacciBuffer) -> Int { s.size }

pub fn ds_heap_fibonacci_buffer_get(s : DsheapfibonacciBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_buffer_set(s : DsheapfibonacciBuffer, i : Int, v : Double) -> DsheapfibonacciBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_sum(s : DsheapfibonacciBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_buffer_mean(s : DsheapfibonacciBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_buffer_scale(s : DsheapfibonacciBuffer, f : Double) -> DsheapfibonacciBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_add(a : DsheapfibonacciBuffer, b : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_buffer_copy(s : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_fill(s : DsheapfibonacciBuffer, v : Double) -> DsheapfibonacciBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_min(s : DsheapfibonacciBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_buffer_max(s : DsheapfibonacciBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_buffer_to_string(s : DsheapfibonacciBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cursor_make(size : Int) -> DsheapfibonacciCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_cursor_len(s : DsheapfibonacciCursor) -> Int { s.size }

pub fn ds_heap_fibonacci_cursor_get(s : DsheapfibonacciCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_cursor_set(s : DsheapfibonacciCursor, i : Int, v : Double) -> DsheapfibonacciCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_sum(s : DsheapfibonacciCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_cursor_mean(s : DsheapfibonacciCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_cursor_scale(s : DsheapfibonacciCursor, f : Double) -> DsheapfibonacciCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_add(a : DsheapfibonacciCursor, b : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_cursor_copy(s : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_fill(s : DsheapfibonacciCursor, v : Double) -> DsheapfibonacciCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_min(s : DsheapfibonacciCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_cursor_max(s : DsheapfibonacciCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_cursor_to_string(s : DsheapfibonacciCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_view_make(size : Int) -> DsheapfibonacciView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_view_len(s : DsheapfibonacciView) -> Int { s.size }

pub fn ds_heap_fibonacci_view_get(s : DsheapfibonacciView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_view_set(s : DsheapfibonacciView, i : Int, v : Double) -> DsheapfibonacciView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_sum(s : DsheapfibonacciView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_view_mean(s : DsheapfibonacciView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_view_scale(s : DsheapfibonacciView, f : Double) -> DsheapfibonacciView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_add(a : DsheapfibonacciView, b : DsheapfibonacciView) -> DsheapfibonacciView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_view_copy(s : DsheapfibonacciView) -> DsheapfibonacciView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_fill(s : DsheapfibonacciView, v : Double) -> DsheapfibonacciView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_min(s : DsheapfibonacciView) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_view_max(s : DsheapfibonacciView) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_view_to_string(s : DsheapfibonacciView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_range_make(size : Int) -> DsheapfibonacciRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_range_len(s : DsheapfibonacciRange) -> Int { s.size }

pub fn ds_heap_fibonacci_range_get(s : DsheapfibonacciRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_range_set(s : DsheapfibonacciRange, i : Int, v : Double) -> DsheapfibonacciRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_sum(s : DsheapfibonacciRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_range_mean(s : DsheapfibonacciRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_range_scale(s : DsheapfibonacciRange, f : Double) -> DsheapfibonacciRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_add(a : DsheapfibonacciRange, b : DsheapfibonacciRange) -> DsheapfibonacciRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_range_copy(s : DsheapfibonacciRange) -> DsheapfibonacciRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_fill(s : DsheapfibonacciRange, v : Double) -> DsheapfibonacciRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_min(s : DsheapfibonacciRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_range_max(s : DsheapfibonacciRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_range_to_string(s : DsheapfibonacciRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_slice_make(size : Int) -> DsheapfibonacciSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_slice_len(s : DsheapfibonacciSlice) -> Int { s.size }

pub fn ds_heap_fibonacci_slice_get(s : DsheapfibonacciSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_slice_set(s : DsheapfibonacciSlice, i : Int, v : Double) -> DsheapfibonacciSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_sum(s : DsheapfibonacciSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_slice_mean(s : DsheapfibonacciSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_slice_scale(s : DsheapfibonacciSlice, f : Double) -> DsheapfibonacciSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_add(a : DsheapfibonacciSlice, b : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_slice_copy(s : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_fill(s : DsheapfibonacciSlice, v : Double) -> DsheapfibonacciSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_min(s : DsheapfibonacciSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_slice_max(s : DsheapfibonacciSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_slice_to_string(s : DsheapfibonacciSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

