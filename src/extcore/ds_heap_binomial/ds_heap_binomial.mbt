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

pub fn ds_heap_binomial_frame_len(s : DsheapbinomialFrame) -> Int { s.size }

pub fn ds_heap_binomial_frame_get(s : DsheapbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_frame_set(s : DsheapbinomialFrame, i : Int, v : Double) -> DsheapbinomialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_sum(s : DsheapbinomialFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_frame_mean(s : DsheapbinomialFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_frame_scale(s : DsheapbinomialFrame, f : Double) -> DsheapbinomialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_add(a : DsheapbinomialFrame, b : DsheapbinomialFrame) -> DsheapbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_frame_copy(s : DsheapbinomialFrame) -> DsheapbinomialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_fill(s : DsheapbinomialFrame, v : Double) -> DsheapbinomialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_min(s : DsheapbinomialFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_frame_max(s : DsheapbinomialFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_frame_to_string(s : DsheapbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_table_make(size : Int) -> DsheapbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_table_len(s : DsheapbinomialTable) -> Int { s.size }

pub fn ds_heap_binomial_table_get(s : DsheapbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_table_set(s : DsheapbinomialTable, i : Int, v : Double) -> DsheapbinomialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_sum(s : DsheapbinomialTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_table_mean(s : DsheapbinomialTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_table_scale(s : DsheapbinomialTable, f : Double) -> DsheapbinomialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_add(a : DsheapbinomialTable, b : DsheapbinomialTable) -> DsheapbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_table_copy(s : DsheapbinomialTable) -> DsheapbinomialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_fill(s : DsheapbinomialTable, v : Double) -> DsheapbinomialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_min(s : DsheapbinomialTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_table_max(s : DsheapbinomialTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_table_to_string(s : DsheapbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_graphn_make(size : Int) -> DsheapbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_graphn_len(s : DsheapbinomialGraphN) -> Int { s.size }

pub fn ds_heap_binomial_graphn_get(s : DsheapbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_graphn_set(s : DsheapbinomialGraphN, i : Int, v : Double) -> DsheapbinomialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_sum(s : DsheapbinomialGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_graphn_mean(s : DsheapbinomialGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_graphn_scale(s : DsheapbinomialGraphN, f : Double) -> DsheapbinomialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_add(a : DsheapbinomialGraphN, b : DsheapbinomialGraphN) -> DsheapbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_graphn_copy(s : DsheapbinomialGraphN) -> DsheapbinomialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_fill(s : DsheapbinomialGraphN, v : Double) -> DsheapbinomialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_min(s : DsheapbinomialGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_graphn_max(s : DsheapbinomialGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_graphn_to_string(s : DsheapbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_node_make(size : Int) -> DsheapbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_node_len(s : DsheapbinomialNode) -> Int { s.size }

pub fn ds_heap_binomial_node_get(s : DsheapbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_node_set(s : DsheapbinomialNode, i : Int, v : Double) -> DsheapbinomialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_sum(s : DsheapbinomialNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_node_mean(s : DsheapbinomialNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_node_scale(s : DsheapbinomialNode, f : Double) -> DsheapbinomialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_add(a : DsheapbinomialNode, b : DsheapbinomialNode) -> DsheapbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_node_copy(s : DsheapbinomialNode) -> DsheapbinomialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_fill(s : DsheapbinomialNode, v : Double) -> DsheapbinomialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_min(s : DsheapbinomialNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_node_max(s : DsheapbinomialNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_node_to_string(s : DsheapbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_edge_make(size : Int) -> DsheapbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_edge_len(s : DsheapbinomialEdge) -> Int { s.size }

pub fn ds_heap_binomial_edge_get(s : DsheapbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_edge_set(s : DsheapbinomialEdge, i : Int, v : Double) -> DsheapbinomialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_sum(s : DsheapbinomialEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_edge_mean(s : DsheapbinomialEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_edge_scale(s : DsheapbinomialEdge, f : Double) -> DsheapbinomialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_add(a : DsheapbinomialEdge, b : DsheapbinomialEdge) -> DsheapbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_edge_copy(s : DsheapbinomialEdge) -> DsheapbinomialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_fill(s : DsheapbinomialEdge, v : Double) -> DsheapbinomialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_min(s : DsheapbinomialEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_edge_max(s : DsheapbinomialEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_edge_to_string(s : DsheapbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_path_make(size : Int) -> DsheapbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_path_len(s : DsheapbinomialPath) -> Int { s.size }

pub fn ds_heap_binomial_path_get(s : DsheapbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_path_set(s : DsheapbinomialPath, i : Int, v : Double) -> DsheapbinomialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_sum(s : DsheapbinomialPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_path_mean(s : DsheapbinomialPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_path_scale(s : DsheapbinomialPath, f : Double) -> DsheapbinomialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_add(a : DsheapbinomialPath, b : DsheapbinomialPath) -> DsheapbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_path_copy(s : DsheapbinomialPath) -> DsheapbinomialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_fill(s : DsheapbinomialPath, v : Double) -> DsheapbinomialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_min(s : DsheapbinomialPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_path_max(s : DsheapbinomialPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_path_to_string(s : DsheapbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_cluster_make(size : Int) -> DsheapbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_cluster_len(s : DsheapbinomialCluster) -> Int { s.size }

pub fn ds_heap_binomial_cluster_get(s : DsheapbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_cluster_set(s : DsheapbinomialCluster, i : Int, v : Double) -> DsheapbinomialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_sum(s : DsheapbinomialCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_cluster_mean(s : DsheapbinomialCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_cluster_scale(s : DsheapbinomialCluster, f : Double) -> DsheapbinomialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_add(a : DsheapbinomialCluster, b : DsheapbinomialCluster) -> DsheapbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_cluster_copy(s : DsheapbinomialCluster) -> DsheapbinomialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_fill(s : DsheapbinomialCluster, v : Double) -> DsheapbinomialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_min(s : DsheapbinomialCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_cluster_max(s : DsheapbinomialCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_cluster_to_string(s : DsheapbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_model_make(size : Int) -> DsheapbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_model_len(s : DsheapbinomialModel) -> Int { s.size }

pub fn ds_heap_binomial_model_get(s : DsheapbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_model_set(s : DsheapbinomialModel, i : Int, v : Double) -> DsheapbinomialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_sum(s : DsheapbinomialModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_model_mean(s : DsheapbinomialModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_model_scale(s : DsheapbinomialModel, f : Double) -> DsheapbinomialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_add(a : DsheapbinomialModel, b : DsheapbinomialModel) -> DsheapbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_model_copy(s : DsheapbinomialModel) -> DsheapbinomialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_fill(s : DsheapbinomialModel, v : Double) -> DsheapbinomialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_min(s : DsheapbinomialModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_model_max(s : DsheapbinomialModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_model_to_string(s : DsheapbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_layer_make(size : Int) -> DsheapbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_layer_len(s : DsheapbinomialLayer) -> Int { s.size }

pub fn ds_heap_binomial_layer_get(s : DsheapbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_layer_set(s : DsheapbinomialLayer, i : Int, v : Double) -> DsheapbinomialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_sum(s : DsheapbinomialLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_layer_mean(s : DsheapbinomialLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_layer_scale(s : DsheapbinomialLayer, f : Double) -> DsheapbinomialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_add(a : DsheapbinomialLayer, b : DsheapbinomialLayer) -> DsheapbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_layer_copy(s : DsheapbinomialLayer) -> DsheapbinomialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_fill(s : DsheapbinomialLayer, v : Double) -> DsheapbinomialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_min(s : DsheapbinomialLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_layer_max(s : DsheapbinomialLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_layer_to_string(s : DsheapbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_buffer_make(size : Int) -> DsheapbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_buffer_len(s : DsheapbinomialBuffer) -> Int { s.size }

pub fn ds_heap_binomial_buffer_get(s : DsheapbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_buffer_set(s : DsheapbinomialBuffer, i : Int, v : Double) -> DsheapbinomialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_sum(s : DsheapbinomialBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_buffer_mean(s : DsheapbinomialBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_buffer_scale(s : DsheapbinomialBuffer, f : Double) -> DsheapbinomialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_add(a : DsheapbinomialBuffer, b : DsheapbinomialBuffer) -> DsheapbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_buffer_copy(s : DsheapbinomialBuffer) -> DsheapbinomialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_fill(s : DsheapbinomialBuffer, v : Double) -> DsheapbinomialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_min(s : DsheapbinomialBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_buffer_max(s : DsheapbinomialBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_buffer_to_string(s : DsheapbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_cursor_make(size : Int) -> DsheapbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_cursor_len(s : DsheapbinomialCursor) -> Int { s.size }

pub fn ds_heap_binomial_cursor_get(s : DsheapbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_cursor_set(s : DsheapbinomialCursor, i : Int, v : Double) -> DsheapbinomialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_sum(s : DsheapbinomialCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_cursor_mean(s : DsheapbinomialCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_cursor_scale(s : DsheapbinomialCursor, f : Double) -> DsheapbinomialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_add(a : DsheapbinomialCursor, b : DsheapbinomialCursor) -> DsheapbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_cursor_copy(s : DsheapbinomialCursor) -> DsheapbinomialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_fill(s : DsheapbinomialCursor, v : Double) -> DsheapbinomialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_min(s : DsheapbinomialCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_cursor_max(s : DsheapbinomialCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_cursor_to_string(s : DsheapbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_view_make(size : Int) -> DsheapbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_view_len(s : DsheapbinomialView) -> Int { s.size }

pub fn ds_heap_binomial_view_get(s : DsheapbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_view_set(s : DsheapbinomialView, i : Int, v : Double) -> DsheapbinomialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_sum(s : DsheapbinomialView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_view_mean(s : DsheapbinomialView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_view_scale(s : DsheapbinomialView, f : Double) -> DsheapbinomialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_add(a : DsheapbinomialView, b : DsheapbinomialView) -> DsheapbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_view_copy(s : DsheapbinomialView) -> DsheapbinomialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_fill(s : DsheapbinomialView, v : Double) -> DsheapbinomialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_min(s : DsheapbinomialView) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_view_max(s : DsheapbinomialView) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_view_to_string(s : DsheapbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_range_make(size : Int) -> DsheapbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_range_len(s : DsheapbinomialRange) -> Int { s.size }

pub fn ds_heap_binomial_range_get(s : DsheapbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_range_set(s : DsheapbinomialRange, i : Int, v : Double) -> DsheapbinomialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_sum(s : DsheapbinomialRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_range_mean(s : DsheapbinomialRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_range_scale(s : DsheapbinomialRange, f : Double) -> DsheapbinomialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_add(a : DsheapbinomialRange, b : DsheapbinomialRange) -> DsheapbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_range_copy(s : DsheapbinomialRange) -> DsheapbinomialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_fill(s : DsheapbinomialRange, v : Double) -> DsheapbinomialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_min(s : DsheapbinomialRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_range_max(s : DsheapbinomialRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_range_to_string(s : DsheapbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_slice_make(size : Int) -> DsheapbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_slice_len(s : DsheapbinomialSlice) -> Int { s.size }

pub fn ds_heap_binomial_slice_get(s : DsheapbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_slice_set(s : DsheapbinomialSlice, i : Int, v : Double) -> DsheapbinomialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_sum(s : DsheapbinomialSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_slice_mean(s : DsheapbinomialSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_slice_scale(s : DsheapbinomialSlice, f : Double) -> DsheapbinomialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_add(a : DsheapbinomialSlice, b : DsheapbinomialSlice) -> DsheapbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_slice_copy(s : DsheapbinomialSlice) -> DsheapbinomialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_fill(s : DsheapbinomialSlice, v : Double) -> DsheapbinomialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_min(s : DsheapbinomialSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_slice_max(s : DsheapbinomialSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_slice_to_string(s : DsheapbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

